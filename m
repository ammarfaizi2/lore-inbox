Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131791AbRCXUYK>; Sat, 24 Mar 2001 15:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131798AbRCXUYA>; Sat, 24 Mar 2001 15:24:00 -0500
Received: from adsl-204-0-249-112.corp.se.verio.net ([204.0.249.112]:17405
	"EHLO tabby.cats-chateau.net") by vger.kernel.org with ESMTP
	id <S131791AbRCXUXq>; Sat, 24 Mar 2001 15:23:46 -0500
From: Jesse Pollard <jesse@cats-chateau.net>
Reply-To: jesse@cats-chateau.net
To: Paul Jakma <paulj@itg.ie>, Guest section DW <dwguest@win.tue.nl>
Subject: Re: [PATCH] Prevent OOM from killing init
Date: Sat, 24 Mar 2001 14:19:39 -0600
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Michael Peddemors <michael@linuxmagic.com>,
        Stephen Clouse <stephenc@theiqgroup.com>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0103232013490.31380-100000@rossi.itg.ie>
In-Reply-To: <Pine.LNX.4.33.0103232013490.31380-100000@rossi.itg.ie>
MIME-Version: 1.0
Message-Id: <01032414222102.03927@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2001, Paul Jakma wrote:
>On Fri, 23 Mar 2001, Guest section DW wrote:
>
>> But yes, I am complaining because Linux by default is unreliable.
>
>no, your distribution is unreliable by default.
>
>> I strongly prefer a system that is reliable by default,
>> and I'll leave it to others to run it in an unreliable mode.
>
>currently, setting sensible user limits on my machines means i never
>get a hosed machine due to OOM. These limits are easy to set via
>pam_limits. (not perfect though, i think its session specific..)

Process specific. Each forked process gets the same limits. You get OOM
as soon as all processes together use more than the system capacity.

>granted, if the machine hasn't been setup with user limits, then linux
>doesn't deal at all well with OOM, so this should be fixed. but it can
>easily be argued that admin error in not configuring limits is the
>main cause for OOM.

Admin has no real control is the problem. Limits are only good for one
process. As soon as that process forks one other process then the
useage limit is twice the limit established.

>> Andries
>
>regards,
>
>--paulj

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: jesse@cats-chateau.net

Any opinions expressed are solely my own.
