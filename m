Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314558AbSEVVqU>; Wed, 22 May 2002 17:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314645AbSEVVqU>; Wed, 22 May 2002 17:46:20 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:37779 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S314558AbSEVVqT>; Wed, 22 May 2002 17:46:19 -0400
Date: Wed, 22 May 2002 17:46:14 -0400
From: Doug Ledford <dledford@redhat.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, bert hubert <ahu@ds9a.nl>,
        "M. Edward Borasky" <znmeb@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: Have the 2.4 kernel memory management problems on large machines been fixed?
Message-ID: <20020522174614.B2819@redhat.com>
Mail-Followup-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, bert hubert <ahu@ds9a.nl>,
	"M. Edward Borasky" <znmeb@aracnet.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E17AXWu-0001vL-00@the-village.bc.nu> <1404136612.1022057787@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 08:56:28AM -0700, Martin J. Bligh wrote:
> > 7.3 has some of what is needed but not all. 
> 
> Can you outline the changes in this area? I want to make sure we're
> not all fighting the same problems seperately ;-) I know bounce
> buffers is one large element of that, though I believe you still
> only go up to 4Gb, unless I'm mistaken?

Yes, it only goes up to 4Gb.  It's because of the error handling code in 
the SCSI mid-layer and above, it fails to properly handle the >4gb sg 
entries on error conditions.  I'm working on that now and should have it 
fixed soon.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
