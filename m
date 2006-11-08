Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754284AbWKHFNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754284AbWKHFNQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 00:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754285AbWKHFNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 00:13:16 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:5539 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1754281AbWKHFNP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 00:13:15 -0500
Date: Wed, 8 Nov 2006 10:42:57 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: "Paul Menage" <menage@google.com>, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-ID: <20061108051257.GB2964@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061031115342.GB9588@in.ibm.com> <6599ad830610310846m5d718d22p5e1b569d4ef4e63@mail.gmail.com> <20061101172540.GA8904@in.ibm.com> <6599ad830611011537i2de812fck99822d3dd1314992@mail.gmail.com> <20061106124948.GA3027@in.ibm.com> <6599ad830611061223m77c0ef1ei72bd7729d9284ec6@mail.gmail.com> <20061107104118.f02a1114.pj@sgi.com> <6599ad830611071107u4226ec17h5facc7ee2ad53174@mail.gmail.com> <6599ad830611071421s7792bbb1qd9c7b1fc840dfa50@mail.gmail.com> <20061107191518.c094ce1a.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061107191518.c094ce1a.pj@sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2006 at 07:15:18PM -0800, Paul Jackson wrote:
> It goes like this ... grab a cup of coffee.

Thanks for the nice and big writeup!

> Each directory in a container file system has a file called 'tasks'
> listing the pids of the tasks (newline separated decimal ASCII format)
> in that partition element.

As was discussed in a previous thread, having a 'threads' file also will
be good.

	http://lkml.org/lkml/2006/11/1/386

> Because containers define a partition of the tasks in a system, each
> task will always be in exactly one of the partition elements of a
> container file system.  Tasks are moved from one partition element
> to another by writing their pid (decimal ASCII) into the 'tasks'
> file of the receiving directory.

Writing to 'tasks' file will move that single thread to the new
container. Writing to 'threads' file will move all the threads of the
process into the new container.

-- 
Regards,
vatsa
