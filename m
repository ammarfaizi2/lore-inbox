Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWFGRHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWFGRHn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 13:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWFGRHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 13:07:43 -0400
Received: from gw.goop.org ([64.81.55.164]:1493 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932345AbWFGRHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 13:07:43 -0400
Message-ID: <448707DA.9090801@goop.org>
Date: Wed, 07 Jun 2006 10:07:38 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Don Zickus <dzickus@redhat.com>
CC: Shaohua Li <shaohua.li@intel.com>, Miles Lane <miles.lane@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in	arch/i386/kernel/nmi.c:174
References: <4480C102.3060400@goop.org> <4483DF32.4090608@goop.org> <20060605004823.566b266c.akpm@osdl.org> <a44ae5cd0606050135w66c2abeu698394b4268e4790@mail.gmail.com> <1149576246.32046.166.camel@sli10-desk.sh.intel.com> <4485AC1F.9050001@goop.org> <20060607024938.GG11696@redhat.com>
In-Reply-To: <20060607024938.GG11696@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don Zickus wrote:
> Makes the start/stop paths of nmi watchdog more robust to handle the
> suspend/resume cases more gracefully.
>   
This solves the original symptom, but I'm seeing something else now.  
After the second resume, there's a noticable pause after it brings cpu 1 
online.  After the third resume it's a longer pause, and after the 4th 
it just hangs there.  The system is up enough to respond to sysreq, but 
nothing in usermode seems to be actually running.  I'll try and get a 
better understanding of what I'm seeing later today.

    J
