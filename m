Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWCUJoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWCUJoy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 04:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWCUJoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 04:44:54 -0500
Received: from quechua.inka.de ([193.197.184.2]:45227 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S932370AbWCUJox (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 04:44:53 -0500
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: Announcing crypto suspend
To: linux-kernel@vger.kernel.org
Date: Tue, 21 Mar 2006 10:45:40 +0100
References: <20060320080439.GA4653@elf.ucw.cz> <1142879707.9475.4.camel@localhost.localdomain> <200603201954.45572.rjw@sisk.pl>
User-Agent: KNode/0.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8Bit
X-Ciphire-Security: plain
Message-Id: <20060321094449.0760E12768C@dungeon.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> First, you need to generate the RSA key pair using suspend-keygen and save
> the output file as /etc/suspend.key (or something else pointed to by
> the "RSA key file =" configuration parameter of suspend).  This file
> contains the public modulus (n), public exponent (e) and
> Blowfish-encrypted private exponent (d) of the RSA key pair.
> 
> Then, the suspend utility will load the contents of this file,  generate a
> random session key (k) and initialization vector (i) for the image
> encryption and use (n, e) to encrypt these values with RSA.  The encrypted
> k, i as well as the contents of the RSA key file will be saved in the
> image header.
> 
> The resume utility will read n, e and (encrypted) d as well as (encrypted)
> k, i from the image header.  Then it will ask the user for a passphrase
> and will try to decrypt d using it.  Next, it will use (n, e, d) to
> decrypt k, i needed for decrypting the image.

what interface will those tools use? can I replace them with my own
code, e.g. that uses smart cards instead of an encrypted public key
on a disk?

Andreas

