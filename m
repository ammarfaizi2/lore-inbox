Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVGBNO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVGBNO5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 09:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVGBNO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 09:14:57 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:58242 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261153AbVGBNO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 09:14:56 -0400
Date: Sat, 2 Jul 2005 08:14:37 -0500
From: Michael Raymond <mraymond@sgi.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>,
       Mathieu Desnoyers <compudj@krystal.dyndns.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [ltt-dev] [PATCH/RFC] Significantly reworked LTT core
Message-ID: <20050702081437.A57232@xanatos.americas.sgi.com>
References: <42C60001.5050609@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <42C60001.5050609@opersys.com>; from karim@opersys.com on Fri, Jul 01, 2005 at 10:46:25PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Karim, three comments:
- CPU ID needs be bigger than 8-bits, else you can only support up to 256p
- Are 8-bit event IDs big enough?  A comment explainig that sub-IDs should
  be placed within the log record would help avoid the issue of the 8-bit
  space disappearing too quickly
- To avoid the problem of RelayFS non-reenterancy I think ltt_log_event() will
  need a hook at its end so that whatever mechanism was used to avoid the
  situation can be disabled.
  	    	   	    				Thanks,
							       Michael
-- 
Michael A. Raymond              Office: (651) 683-3434
Core OS Group                   Real-Time System Software
