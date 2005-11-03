Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbVKCMRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbVKCMRE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 07:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbVKCMRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 07:17:04 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:40592 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964830AbVKCMRD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 07:17:03 -0500
Subject: Re: XFS information leak during crash
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nathan Scott <nathans@sgi.com>
Cc: Jan Kasprzak <kas@fi.muni.cz>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
In-Reply-To: <20051103111115.C6081538@wobbly.melbourne.sgi.com>
References: <20051102212722.GC6759@fi.muni.cz>
	 <20051103101107.O6239737@wobbly.melbourne.sgi.com>
	 <20051102233629.GD6759@fi.muni.cz>
	 <20051103104956.B6081538@wobbly.melbourne.sgi.com>
	 <20051103000317.GE6759@fi.muni.cz>
	 <20051103111115.C6081538@wobbly.melbourne.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Nov 2005 12:45:49 +0000
Message-Id: <1131021949.18848.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-11-03 at 11:11 +1100, Nathan Scott wrote:
> On Thu, Nov 03, 2005 at 01:03:17AM +0100, Jan Kasprzak wrote:
> > : it would only ever be uninitialised, previously-free space.
> > 
> > 	Yes, but an old data from previously deleted files
> > (sendmail's temporary files, vim save files, etc) may contain
> > a sensitive information.
> 
> Indeed.  But this is a generic issue affecting most filesystems;
> its not specific to XFS as your original mail claimed.

Very true. You can use ext3 in data journalling mode if this is a
concern but that guarantee has a performance cost

