Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423027AbWBOH7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423027AbWBOH7q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 02:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423026AbWBOH7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 02:59:46 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:19094 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1423028AbWBOH7p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 02:59:45 -0500
Date: Wed, 15 Feb 2006 07:59:42 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: psusi@cfl.rr.com, jzb@aexorsyst.com, linux-kernel@vger.kernel.org
Subject: Re: root=/dev/sda1 fails but root=0x0801 works...
Message-ID: <20060215075942.GK27946@ftp.linux.org.uk>
References: <200602132316.15992.jzb@aexorsyst.com> <43F1FA74.80607@cfl.rr.com> <20060214162458.GD27946@ftp.linux.org.uk> <20060214225950.3a697ec8.akpm@osdl.org> <20060215071018.GJ27946@ftp.linux.org.uk> <20060214233256.2969b4b7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214233256.2969b4b7.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 11:32:56PM -0800, Andrew Morton wrote:
> > 
> > Details, please.
> 
> I just don't remember, sorry.  From inspection it _looks_ OK.  But I do
> remember getting -ENOENT, looking at the pathnames and deciding that it was
> miles off.
> 
> swsusp has a habit of leaving a trailing \n at the end of resume_file, but
> it was more than that.
> 
> And I threw away the patch which exercised this.  Oh well.
> 
> (Wonders whether software_resume()'s call to name_to_dev_t() can work and
> if so, whether all that stuff as well as name_to_dev_t() can become __init).

Well...  FWIC, it should go into kinit and disappear from the kernel proper,
along with all its callers.  Now that hpa had created kernel+klibc+kinit
tree, we might finally get there...
