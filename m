Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284220AbRLKXsz>; Tue, 11 Dec 2001 18:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284242AbRLKXsq>; Tue, 11 Dec 2001 18:48:46 -0500
Received: from zok.sgi.com ([204.94.215.101]:38328 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S284220AbRLKXsc>;
	Tue, 11 Dec 2001 18:48:32 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Craig Christophel <merlin@transgeek.com>
Cc: Olaf Kirch <okir@monad.swb.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre8 -- fix to compile nfs as module 
In-Reply-To: Your message of "Tue, 11 Dec 2001 08:19:35 CDT."
             <20011211091616.8AE46C7382@smtp.transgeek.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 12 Dec 2001 10:48:22 +1100
Message-ID: <10961.1008114502@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2001 08:19:35 -0500, 
Craig Christophel <merlin@transgeek.com> wrote:
>added an ifdef for modversions in fs/nfs/inode.c.  

Don't!  The Makefile automatically adds modversions.h when required,
any code that explicitly includes modversions.h is broken.

