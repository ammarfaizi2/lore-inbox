Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292817AbSCTWB4>; Wed, 20 Mar 2002 17:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293109AbSCTWBs>; Wed, 20 Mar 2002 17:01:48 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:30453
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S292817AbSCTWB1>; Wed, 20 Mar 2002 17:01:27 -0500
Date: Wed, 20 Mar 2002 14:02:41 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Putrid Elevator Behavior 2.4.18/19
Message-ID: <20020320220241.GC29857@matchmail.com>
Mail-Followup-To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020320120455.A19074@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2002 at 12:04:55PM -0700, Jeff V. Merkey wrote:
> 
> 
> 
> Jens/Linux,
> 
> The elevator code is malfunctioning in 2.4.18/19-pre when we start 
> reaching the upward limits with multiple 3Ware adapters 
> running together.  We started seeing the problem when we went to 
> 64 K aligned writes with sustained > 200 MB/S writes to 
> multiple 3Ware adapters.  
> 
> We have verified that the 3Ware adapters are not holding the request
> off, but that one of the requests is getting severely starved and
> does not get posted to the 3Ware adapters until thousands of IOs
> have gone before it.  
> 

This elevator starvation problem has been identified and a patch already
merged into 2.4.19-pre2.

Can you verify the affects it produces for your workload?
