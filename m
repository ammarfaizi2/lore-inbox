Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263225AbSJFCbi>; Sat, 5 Oct 2002 22:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263192AbSJFCbi>; Sat, 5 Oct 2002 22:31:38 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:3854
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263225AbSJFCbi>; Sat, 5 Oct 2002 22:31:38 -0400
Subject: Re: Unable to kill processes in D-state
From: Robert Love <rml@tech9.net>
To: jw schultz <jw@pegasys.ws>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021006021802.GA31878@pegasys.ws>
References: <20021005090705.GA18475@stud.ntnu.no>
	<1033841462.1247.3716.camel@phantasy> <20021005182740.GC16200@vagabond>
	<20021005235614.GC25827@stud.ntnu.no>  <20021006021802.GA31878@pegasys.ws>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Oct 2002 22:37:48 -0400
Message-Id: <1033871869.1247.4397.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-05 at 22:18, jw schultz wrote:

> They shouldn't be affecting the load average because they
> aren't on the runqueue.

TASK_UNINTERRUPTIBLE processes are counted in count_active_tasks() -
because it is assumed they will only sleep a very short while - which is
what is used in the load balance.

	Robert Love

