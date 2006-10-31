Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423061AbWJaJ54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423061AbWJaJ54 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 04:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423062AbWJaJ54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 04:57:56 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4358 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S1423061AbWJaJ5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 04:57:55 -0500
Date: Tue, 31 Oct 2006 09:57:43 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Steve Grubb <sgrubb@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] handle ext3 directory corruption better
Message-ID: <20061031095742.GA4241@ucw.cz>
References: <200610211129.23216.sgrubb@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610211129.23216.sgrubb@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The initial image is created in one of 2 ways, either dd a file or mkdir a 
> directory depending on what the filesystem creation tools call for. To 
> corrupt the image, a version of mangle is used. Mangle is a program that 
> corrupts about 10% of the data and favors bytes with a value > 128 to induce 
> signed/unsigned problems. The corrupted image is exercised by a program 
> called run_test. I separated it from the main program so that you can replay 
> a test and debug what is happening.
> 
> So, to wrap up...anyone that has anything to do with file system development 
> may want to give this tool a try to see how robust any given file system is. 
> The program can be grabbed here:
> 
> http://people.redhat.com/sgrubb/files/fsfuzzer-0.5.tar.gz

Nice... can you run the same tool against fsck, too?

I did that some time ago, with less evil tool, and got some
interesting results.

(Expectation is that no matter how you corrupt fs, fsck will get it
back to consistent state...)
						Pavel
-- 
Thanks for all the (sleeping) penguins.
