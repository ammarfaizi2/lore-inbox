Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032305AbWLGPG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032305AbWLGPG7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 10:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032306AbWLGPG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 10:06:59 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:62035 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032305AbWLGPG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 10:06:58 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jan Glauber <jan.glauber@de.ibm.com>
Subject: Re: [RFC][PATCH] Pseudo-random number generator
Date: Thu, 7 Dec 2006 16:06:33 +0100
User-Agent: KMail/1.9.5
Cc: linux-crypto <linux-crypto@vger.kernel.org>, linux-kernel@vger.kernel.org
References: <1164979155.5882.23.camel@bender>
In-Reply-To: <1164979155.5882.23.camel@bender>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612071606.33951.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 December 2006 14:19, Jan Glauber wrote:
> I've chosen the char driver since it allows the user to decide which pseudo-random
> numbers he wants to use. That means there is a new interface for the s390
> PRNG, called /dev/prandom.
> 
> I would like to know if there are any objections, especially with the chosen device
> name.

This may be a stupid question, but what is it _good_ for? My understanding is
that the crypt_s390_kmc() opcodes work in user mode as well as kernel mode, so
you should not need a character device at all, but maybe just a small tool
that spits prandom data to stdout.

	Arnd <><
