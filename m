Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262377AbSI2DIw>; Sat, 28 Sep 2002 23:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262381AbSI2DIw>; Sat, 28 Sep 2002 23:08:52 -0400
Received: from ns.suse.de ([213.95.15.193]:6663 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262377AbSI2DIv>;
	Sat, 28 Sep 2002 23:08:51 -0400
Date: Sun, 29 Sep 2002 05:14:14 +0200
From: Andi Kleen <ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: John Levon <levon@movementarian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] oprofile for 2.5.39
Message-ID: <20020929051414.A19273@wotan.suse.de>
References: <20020929014440.GA66796@compsoc.man.ac.uk.suse.lists.linux.kernel> <p737kh5sf45.fsf@oldwotan.suse.de> <20020929025224.GA68153@compsoc.man.ac.uk> <20020929050807.A17869@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020929050807.A17869@wotan.suse.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think you can easily do that by keeping state per cpu in the 
> NMI handler.
> 
> 	if (current == __get_cpu_var(oprofile_cpustate)) { 
                ^^
Should be != of course.


-Andi

> 		/* log current */
> 		__get_cpu_var(oprofile_cpustate) = current; 	
> 	} else { 
> 		/* do nothing */ 
> 	}
> 	/* log EIP */
