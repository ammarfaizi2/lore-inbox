Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbUBYPVi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 10:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbUBYPVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 10:21:38 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:26771 "EHLO
	quickman.certainkey.com") by vger.kernel.org with ESMTP
	id S261356AbUBYPVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 10:21:36 -0500
Date: Wed, 25 Feb 2004 10:11:36 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: James Morris <jmorris@redhat.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
Message-ID: <20040225151136.GB3852@certainkey.com>
References: <20040224224451.GB32286@certainkey.com> <Xine.LNX.4.44.0402250847220.28934-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0402250847220.28934-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alright then.

http://jlcooke.ca/lkml/crypto_24feb2004.patch

Changes:
 - Added CTR mode to cipher.c
 - Fixed Bug where CTR wasn't getting allocated an IV
 - Added config for OMAC option on encryption
 - Moved scatterwalk stuff to scatterwalk.c added to makefile
 - Removed kmalloc'd scratch space in hmac.c which caused a reported bug.
 - kernel config defaults to build all the IPSec required algorithms as
   well as OMAC (OMAC is only computed if specified by caller)

JLC

On Wed, Feb 25, 2004 at 08:52:36AM -0500, James Morris wrote:
> I think the latter is preferrable.  OMAC should probably be a config 
> option as well.
...
> You could add something like crypto_cipher_omac_final(), to be used by the 
> calling code once it needs the OMAC value, which then calls 
> crypto_cipher_get_omac().

-- 
http://www.certainkey.com
Suite 4560 CTTC
1125 Colonel By Dr.
Ottawa ON, K1S 5B6
