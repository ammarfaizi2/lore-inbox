Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266028AbUGOAjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266028AbUGOAjP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 20:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266069AbUGOAik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 20:38:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7644 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266028AbUGOATg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 20:19:36 -0400
Date: Thu, 15 Jul 2004 01:19:35 +0100
From: Matthew Wilcox <willy@debian.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH][2.6.8-rc1-mm1] drivers/scsi/sg.c gcc341 inlining fix
Message-ID: <20040715001935.GB32326@parcelfarce.linux.theplanet.co.uk>
References: <200407141751.i6EHprhf009045@harpo.it.uu.se> <40F57D14.9030005@pobox.com> <20040714143508.3dc25d58.akpm@osdl.org> <40F5C42E.1060708@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F5C42E.1060708@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 07:39:26PM -0400, Jeff Garzik wrote:
> ???  C does not require ordering of function _implementations_, except 
> for this gcc brokenness.

Actually, GCC has always required that inlines be specified first
for them to be inlined, even in earlier versions.  For example, from the
gcc 3.3 manual:

Some calls cannot be integrated for various reasons (in particular,
calls that precede the function's definition cannot be integrated, and
neither can recursive calls within the definition).  If there is a
nonintegrated call, then the function is compiled to assembler code as
usual.

> The above example allows one to do what one normally does with 
> non-inlines:  order code to enhance readability, and the compiler will 
> Do The Right Thing and utilize it in the best way the CPU will function.

I find it enhances readability to place functions in reverse order.
That way I know I can just go to the top of a file, and the first match
on the function's name is its definition.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
