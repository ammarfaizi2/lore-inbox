Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264518AbTIDBwv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 21:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbTIDBwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 21:52:51 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:62219
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264518AbTIDBvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 21:51:45 -0400
Date: Wed, 3 Sep 2003 18:52:03 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH]O20int
Message-ID: <20030904015203.GL16361@matchmail.com>
Mail-Followup-To: Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <200309040053.22155.kernel@kolivas.org> <200309040855.46034.kernel@kolivas.org> <20030904001214.GH16361@matchmail.com> <200309041027.29407.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309041027.29407.kernel@kolivas.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 10:27:29AM +1000, Con Kolivas wrote:
> On Thu, 4 Sep 2003 10:12, Mike Fedyk wrote:
> > With how many processors? 64? 128?
> 
> 1 cpu = 10ms minimum
> 2 cpus = 20ms minimum
> and so on.
> 
> MIN_TIMESLICE * (1 << (MAX_BONUS - CURRENT_BONUS(p))) * num_online_cpus())
> 
> works out to:
> 10 * num_online_cpus()
> as the minimum
> 
> and 
> 
> 10 * 1024 * num_online_cpus()
> 
> as the maximum

Ok brain fart.  I thought you were deviding based on the number of CPUs...
(misread the macro wrap for a "/" devide)
