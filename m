Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311283AbSCLQn6>; Tue, 12 Mar 2002 11:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311284AbSCLQnt>; Tue, 12 Mar 2002 11:43:49 -0500
Received: from dsl-213-023-043-170.arcor-ip.net ([213.23.43.170]:62364 "EHLO
	starship") by vger.kernel.org with ESMTP id <S289484AbSCLQnk>;
	Tue, 12 Mar 2002 11:43:40 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        Malte Starostik <malte@kde.org>
Subject: Re: directory notifications lost after fork?
Date: Tue, 12 Mar 2002 17:37:51 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200203120247.05611.malte@kde.org> <20020312125543.B4281@kushida.apsleyroad.org>
In-Reply-To: <20020312125543.B4281@kushida.apsleyroad.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16kpHc-0002Lx-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 12, 2002 01:55 pm, Jamie Lokier wrote:
>    - dnotify causes files to notify their parent directory (yes it's
>      ambiguous with hard links).

That's a bitch, isn't it?  The only way I can think of to deal with it is via 
a hardlink reverse map, and there are lots of worms in that can, including 
where you store it, how much it costs to maintain it, how persistent it 
should be and how to make it perfectly non-racy.

-- 
Daniel
