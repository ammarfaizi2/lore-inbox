Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316388AbSEVReO>; Wed, 22 May 2002 13:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316330AbSEVReN>; Wed, 22 May 2002 13:34:13 -0400
Received: from relay1.pair.com ([209.68.1.20]:50956 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S316388AbSEVReL>;
	Wed, 22 May 2002 13:34:11 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3CEBD7A6.3F79B727@kegel.com>
Date: Wed, 22 May 2002 10:38:46 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Saxena, Sunil" <sunil.saxena@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: re: [PATCH] Illegal instruction failures fixes for 2.4.18
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sunil wrote:
> Problem Statement: In March we received an issue from Tom Epperly of LLNL
> that they were seeing bad illegal instruction traps on dual-xeon P4 while
> running their Java workload.  This sighting was reproduced at Intel
> subsequently.  We were able to get CPU traces and now understand this issue.
> James Washer of IBM also notified to us last month on a critical sighting
> that X servers were dumping cores on dual P4 machines.  Linus also
> encountered strange (and nonreproducable) failures with compiler dying with
> illegal instruction while recompiling kernel.
> 
> Root Cause Analysis: The CPU traces helped us identify that there is an
> issue in the order in which page tables are freed in Linux. 

That might explain the mysterious application crashes I've been
seeing on my dual P4 box.  I'll try the patch.
It may take a month to know whether it helps, though.
- Dan
