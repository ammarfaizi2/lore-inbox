Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVFOVaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVFOVaW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 17:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVFOV3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 17:29:46 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:7572 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261593AbVFOV23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 17:28:29 -0400
Date: Wed, 15 Jun 2005 17:28:25 -0400
To: Lukasz Stelmach <stlman@poczta.fm>
Cc: mru@inprovide.com, Patrick McFarland <pmcfarland@downeast.net>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Message-ID: <20050615212825.GS23621@csclub.uwaterloo.ca>
References: <f192987705061303383f77c10c@mail.gmail.com> <yw1xslzl8g1q.fsf@ford.inprovide.com> <42AFE624.4020403@poczta.fm> <200506150454.11532.pmcfarland@downeast.net> <42AFF184.2030209@poczta.fm> <yw1xd5qo2bzd.fsf@ford.inprovide.com> <42B04090.7050703@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B04090.7050703@poczta.fm>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2005 at 04:52:00PM +0200, Lukasz Stelmach wrote:
> There are far more programmes than only iconv. First of all readline
> library is kind of broken because it counts (or at least it did a year
> ago) bytes instead of characters. I won't use UTF-8 nor force anybody
> else to do so until readline will handle it properly.

Well utf8 would sure be nice if everything used it, and getting nice
fonts for it was simple.

> And it is good in a way, however, i think kernel level translation
> should be also possible. Either done by a code in each filsystem or by
> some layer above it.

What do you do if the underlying filesystem can not store some unicode
characters that are allowed on others?

> It depend's on what it is used for. It is very good fs for removable
> media. None of linux native filesystems is good for this because of
> different uids on different machines. Since VFAT uses unicode it is
> possible to see the filenames properly on systems using different
> codepages for the same language (1:1 is possible).

VFAT uses unicode?  I thought it used the same codepage silyness as FAT
did, since after all ti was just supposed to be a long filename
extension to FAT.  Do they use unicode in the long filenames only?

I think UDF is a better filesystem for many types of media since it is
able to me more gently to the sectors storing the meta data than VFAT
ever will be.

Len Sorensen
