Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVACAf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVACAf6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 19:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVACAfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 19:35:12 -0500
Received: from holomorphy.com ([207.189.100.168]:60054 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261364AbVACAdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 19:33:33 -0500
Date: Sun, 2 Jan 2005 16:30:11 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Adrian Bunk <bunk@stusta.de>, William Lee Irwin III <wli@debian.org>,
       Andries Brouwer <aebr@win.tue.nl>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050103003011.GP29332@holomorphy.com>
References: <20050102221534.GG4183@stusta.de> <41D87A64.1070207@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41D87A64.1070207@tmr.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
>> The main advantage with stable kernels in the good old days (tm) when 4 
>> and 6 were even numbers was that you knew if something didn't work, and 
>> upgrading to a new kernel inside this stable kernel series had a 
>> relatively low risk of new breakages. This meant one big migration every 
>> few years and relatively easy upgrades between stable series kernels.
>> Nowadays in 2.6, every new 2.6 kernel has several regressions compared 
>> to the previous one, and additionally obsolete but used code like 
>> ipchains and devfs is scheduled for removal making upgrades even harder 
>> for many users.

On Sun, Jan 02, 2005 at 05:49:08PM -0500, Bill Davidsen wrote:
> And there you have my largest complaint with the new model. If 2.6 is 
> stable, it should not have existing features removed just because 
> someone has a new wet dream about a better but incompatible way to do 
> things. I expect working programs to be deliberately broken in a 
> development tree, but once existing features are removed there simply is 
> no stable set of features.

The presumption is that these changes are frivolous. This is false.
The removals of these features are motivated by their unsoundness,
and those removals resolve real problems. If they did not do so, they
would not pass peer review.


Adrian Bunk wrote:
>> There's the point that most users should use distribution kernels, but 
>> consider e.g. that there are poor souls with new hardware not supported 
>> by the 3 years old 2.4.18 kernel in the stable part of your Debian 
>> distribution.

On Sun, Jan 02, 2005 at 05:49:08PM -0500, Bill Davidsen wrote:
> The stable and development kernel model worked for a decade, partly 
> because people could build on a feature set and not have that feature 
> just go away, leaving the choice of running without fixes or not 
> running. Since we manage to support 2.2 and 2.4 (and perhaps even 2.0?) 
> I don't see why the definition of "stable" can't simply mean "no 
> deletions from the feature set" and let new features come in for those 
> who want them. Absent that 2.4 will be the last stable kernel, in the 
> sense that features won't be deliberately broken or removed.

I can't speak for anyone during the times of more ancient Linux history;
however, developers' dissatisfaction with the development model has been
aired numerous times in certain fora. It has not satisfactorily served
developers or users. Users are locked into distro kernels for
incompatible extensions, and developers are torn between multiple
codebases.

This fragmentation of programmer effort is trivially recognizable as
counterproductive. A single focal point for programmer effort is far
superior for a development model. If the standard of stability is not
passed then the code is not ready to be included in any kernel. Then
the distinction is lost, and each of the fragmented codebases gets a
third-class effort, and a spurious expenditure of effort is wasted on
porting fixes and features across numerous different codebases.

Your estimate of the impact of the feature set upon applications is
also somewhat exaggerated. The system call ABI has remained backward
compatible for extended periods of time covering major releases. In
fact, it would be my personal preference for the next major release to
signify nothing more than a system call ABI change involving the purging
of several older, deprecated system call conventions.


-- wli
