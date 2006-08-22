Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWHVQCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWHVQCx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 12:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbWHVQCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 12:02:53 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:34445 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932076AbWHVQCu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 12:02:50 -0400
Date: Tue, 22 Aug 2006 21:32:23 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Balbir Singh <balbir@in.ibm.com>,
       sekharan@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, matthltc@us.ibm.com, dipankar@in.ibm.com
Subject: Re: [PATCH 7/7] CPU controller V1 - (temporary) cpuset interface
Message-ID: <20060822160223.GB12943@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060820174015.GA13917@in.ibm.com> <20060820174839.GH13917@in.ibm.com> <1156245036.6482.16.camel@Homer.simpson.net> <20060822101028.GB5052@in.ibm.com> <1156257674.4617.8.camel@Homer.simpson.net> <1156260209.6225.7.camel@Homer.simpson.net> <1156261506.6319.6.camel@Homer.simpson.net> <20060822135056.GB7125@in.ibm.com> <1156269931.4954.12.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156269931.4954.12.camel@Homer.simpson.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 06:05:31PM +0000, Mike Galbraith wrote:
> I just did echo "0-1" > cpus.

"cpus" here is the "cpus" file in "all" cpuset? 

If so, that explains why tasks were stuck in cpu 1 (because child cpusets 
arent updated currently with the new cpus setting - which by itself is a tricky 
thing to accomplish under cpusets perhaps).

-- 
Regards,
vatsa
