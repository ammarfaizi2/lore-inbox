Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264557AbSIQWmi>; Tue, 17 Sep 2002 18:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264651AbSIQWmh>; Tue, 17 Sep 2002 18:42:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:18820 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264557AbSIQWmh>;
	Tue, 17 Sep 2002 18:42:37 -0400
Date: Tue, 17 Sep 2002 15:38:28 -0700 (PDT)
Message-Id: <20020917.153828.24171342.davem@redhat.com>
To: ak@suse.de
Cc: jamesclv@us.ibm.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com,
       anton.wilson@camotion.com
Subject: Re: do_gettimeofday vs. rdtsc in the scheduler
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020918004442.A32234@wotan.suse.de>
References: <20020917.141806.49377410.davem@redhat.com>
	<200209171502.04524.jamesclv@us.ibm.com>
	<20020918004442.A32234@wotan.suse.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: Wed, 18 Sep 2002 00:44:42 +0200

   > I don't know how Sun and SGI manage with their larger systems.  Either they 
   > don't do clock sync, or they may have to make expensive tradeoffs.
   
   I guess you could always run NTP between the different CPUs ;) ;) 
   
:-)

More seriously, you don't need to have the cpu tick registers sync'd,
it is the rate that matters.

Once booted, you can sync these system tick registers with a pretty
straight forward algorithm in the kernel.  Bonus points if you can
figure out how to cancel out the cost of moving the system tick sample
cachelines between master and slave in your algorithm :-)
