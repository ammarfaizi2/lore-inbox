Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbWEMQPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWEMQPc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 12:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWEMQPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 12:15:32 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:48560 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S932470AbWEMQPb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 12:15:31 -0400
Date: Sat, 13 May 2006 18:13:25 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Brice Goglin <brice@myri.com>
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
       "Andrew J. Gallatin" <gallatin@myri.com>
Subject: Re: [PATCH 4/6] myri10ge - First half of the driver
Message-ID: <20060513161325.GA27805@electric-eye.fr.zoreil.com>
References: <446259A0.8050504@myri.com> <Pine.GSO.4.44.0605101438410.498-100000@adel.myri.com> <20060510231347.GC25334@electric-eye.fr.zoreil.com> <4463CE88.20301@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4463CE88.20301@myri.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin <brice@myri.com> :
[...]
> > Return in a middle of a spinlock-intensive function. :o(
> >   
> 
> What do you mean ?

It is preferred for maintenance purpose (hello Mr Morton) to organize
the control flow with a single spin_{lock/unlock} pair: if there is a
branch in the control flow, it ought to be joined again before returning.

-- 
Ueimor
