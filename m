Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263245AbSJIAwy>; Tue, 8 Oct 2002 20:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbSJIAwD>; Tue, 8 Oct 2002 20:52:03 -0400
Received: from pizda.ninka.net ([216.101.162.242]:53673 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263228AbSJIAv2>;
	Tue, 8 Oct 2002 20:51:28 -0400
Date: Tue, 08 Oct 2002 17:50:04 -0700 (PDT)
Message-Id: <20021008.175004.73372438.davem@redhat.com>
To: tony.luck@intel.com
Cc: lse-tech@lists.sourceforge.net, nitin.a.kamble@intel.com,
       linux-kernel@vger.kernel.org, tomlins@cam.org, akpm@digeo.com,
       mbligh@aracnet.com
Subject: Re: [Lse-tech] [RFC] numa slab for 2.5.41-mm1
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <39B5C4829263D411AA93009027AE9EBB1EF28EFB@fmsmsx35.fm.intel.com>
References: <39B5C4829263D411AA93009027AE9EBB1EF28EFB@fmsmsx35.fm.intel.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Luck, Tony" <tony.luck@intel.com>
   Date: Tue, 8 Oct 2002 16:29:45 -0700 
   
   If ptr_to_nodeid() is made a platform dependent function, then
   there are some platforms that can do this very efficiently (since
   the nodeid is embedded in some of the high-order address bits), and
   some for which this is complex (e.g. platforms that concatenate
   memory from each node).

I suggest to do it like this, provide the portable version unless some
"HAVE_ARCH_PTR_TO_NODEID" CCP macro is defined in which case the
architecture can make the "address bits" optimization or similar.

The is how we usually handle such things.
