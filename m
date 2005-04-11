Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVDKOSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVDKOSa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 10:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVDKOSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 10:18:30 -0400
Received: from mail.gondor.com ([212.117.64.182]:45329 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S261278AbVDKOS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 10:18:27 -0400
Date: Mon, 11 Apr 2005 16:18:28 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zero disk pages used by swsusp on resume
Message-ID: <20050411141828.GA26924@gondor.com>
References: <42592697.8060909@domdv.de> <200504102040.38403.oliver@neukum.org> <42597E99.8010802@domdv.de> <200504102203.29602.oliver@neukum.org> <20050410201455.GA21568@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050410201455.GA21568@elf.ucw.cz>
X-Request-PGP: http://gondor.com/key.asc
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andreas is right, his patches are needed.
> 
> Currently, if your laptop is stolen after resume, they can still data
> in swsusp image.

Which shows that swsusp is a security risk if you have sensitive data in
RAM. A thief stealing a running computer can get access to memory
contents much more easy if he can just suspend the system and then
recover all the memory contents from disk. Encrypted swsusp wouldn't
help here if the key is stored on the disk as well.

(This is probably not a real risk in most applications, but one should
keep it in mind and disable swsusp if necessary)

Jan

