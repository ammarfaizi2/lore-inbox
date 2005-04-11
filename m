Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVDKG5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVDKG5t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 02:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVDKG5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 02:57:48 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:47752 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261707AbVDKG5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 02:57:47 -0400
Date: Mon, 11 Apr 2005 08:57:45 +0200
From: bert hubert <ahu@ds9a.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christopher Li <lkml@chrisli.org>, Paul Jackson <pj@engr.sgi.com>,
       junkio@cox.net, rddunlap@osdl.org, ross@jose.lug.udel.edu,
       linux-kernel@vger.kernel.org
Subject: Re: more git updates..
Message-ID: <20050411065745.GA29688@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Linus Torvalds <torvalds@osdl.org>,
	Christopher Li <lkml@chrisli.org>, Paul Jackson <pj@engr.sgi.com>,
	junkio@cox.net, rddunlap@osdl.org, ross@jose.lug.udel.edu,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <7vhdifcbmo.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504100824470.1267@ppc970.osdl.org> <20050410115055.2a6c26e8.pj@engr.sgi.com> <Pine.LNX.4.58.0504101338360.1267@ppc970.osdl.org> <20050410190331.GG13853@64m.dyndns.org> <Pine.LNX.4.58.0504101533020.1267@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504101533020.1267@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2005 at 03:38:39PM -0700, Linus Torvalds wrote:

> compressed with zlib, they are all named by the sha1 file, and they all 

Now I know this is a concious decision, but recent zlib allows you to write
out gzip content, at a cost of 14 bytes I think per file, by adding 32 to
the window size. This in turn would allow users to zcat your objects at
ease.

You get confirmation of completeness of the file for free, as gzip encodes
the length of the file at the end.

Perhaps something to consider.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
