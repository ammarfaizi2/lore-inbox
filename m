Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313898AbSHIPS5>; Fri, 9 Aug 2002 11:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314078AbSHIPS5>; Fri, 9 Aug 2002 11:18:57 -0400
Received: from dsl-213-023-043-103.arcor-ip.net ([213.23.43.103]:34956 "EHLO
	starship") by vger.kernel.org with ESMTP id <S313898AbSHIPS4>;
	Fri, 9 Aug 2002 11:18:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: frankeh@watson.ibm.com, davidm@hpl.hp.com,
       David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: large page patch (fwd) (fwd)
Date: Fri, 9 Aug 2002 17:20:52 +0200
X-Mailer: KMail [version 1.3.2]
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, torvalds@transmeta.com,
       gh@us.ibm.com, Martin.Bligh@us.ibm.com, wli@holomorpy.com,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208031240270.9758-100000@home.transmeta.com> <15692.37018.693984.745251@napali.hpl.hp.com> <200208041319.05210.frankeh@watson.ibm.com>
In-Reply-To: <200208041319.05210.frankeh@watson.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17dBZN-0001Ng-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 August 2002 19:19, Hubertus Franke wrote:
> "General Purpose Operating System Support for Multiple Page Sizes"
> htpp://www.usenix.org/publications/library/proceedings/usenix98/full_papers/ganapathy/ganapathy.pdf

This reference describes roughly what I had in mind for active 
defragmentation, which depends on reverse mapping.  The main additional
wrinkle I'd contemplated is introducing a new ZONE_LARGE, and GPF_LARGE,
which means the caller promises not to pin the allocation unit for long
periods and does not mind if the underlying physical page changes
spontaneously.  Defragmenting in this zone is straightforward.

-- 
Daniel
