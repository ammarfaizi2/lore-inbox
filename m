Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319097AbSH2ENW>; Thu, 29 Aug 2002 00:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319102AbSH2ENW>; Thu, 29 Aug 2002 00:13:22 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:43095 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S319097AbSH2ENV>; Thu, 29 Aug 2002 00:13:21 -0400
Date: Thu, 29 Aug 2002 00:17:43 -0400
From: Doug Ledford <dledford@redhat.com>
To: dtonks <dtonks@bellatlantic.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.31 SCSI problem w/solution
Message-ID: <20020829001743.D31167@redhat.com>
Mail-Followup-To: dtonks <dtonks@bellatlantic.net>,
	linux-kernel@vger.kernel.org
References: <3D6D9D56.2090806@bellatlantic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D6D9D56.2090806@bellatlantic.net>; from dtonks@bellatlantic.net on Thu, Aug 29, 2002 at 12:04:38AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2002 at 12:04:38AM -0400, dtonks wrote:
> Hi,
>     When trying to compile module for sym53c416 I received an error 
> 'address not in structure'.  I traced this to - asm-i386/scatterlist.h. 
>  It is missing - char * address - at the beginning of the structure.  I 
> copied scatterlist.h from 2.4.18 and it compiled fine.

Please don't call this a solution.  The char * address item is no longer 
valid, so adding it back to the header won't make the driver work, it just 
makes it compile and then write garbage all over your disks the first time 
you try to use it.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
