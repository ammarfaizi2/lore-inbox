Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262881AbTCKJvz>; Tue, 11 Mar 2003 04:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262882AbTCKJvz>; Tue, 11 Mar 2003 04:51:55 -0500
Received: from unthought.net ([212.97.129.24]:44962 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S262881AbTCKJvy>;
	Tue, 11 Mar 2003 04:51:54 -0500
Date: Tue, 11 Mar 2003 11:02:35 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: "chandrasekhar.nagaraj" <chandrasekhar.nagaraj@patni.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Load Balancing Performance
Message-ID: <20030311100235.GF14814@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	"chandrasekhar.nagaraj" <chandrasekhar.nagaraj@patni.com>,
	linux-kernel@vger.kernel.org
References: <000001c2e7b4$bc52fcc0$e9bba5cc@patni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000001c2e7b4$bc52fcc0$e9bba5cc@patni.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 11, 2003 at 03:28:14PM +0530, chandrasekhar.nagaraj wrote:
> Hi,
> 
...
> But instead of path switching for every buffer head (on call of make
> request), if we switch after  50 buffer heads(ie. after 50 times make
> request is called) then it results in a better  performance.
> Is there any way to find out the optimum value so that the performance is
> optimum.
> The performance is not good only when load balancing is ON. Hence we need
> performance improvement  in the case of load balancing.
> Or is there any other solution to this problem.

Make the request site tunable via. procfs.

Then create a (user space) utility which experiments with various
request sizes and finds the optimum.  Run the tuning program once every
time you set up a new system or change hardware.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
