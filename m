Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319368AbSHVPiQ>; Thu, 22 Aug 2002 11:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319371AbSHVPiQ>; Thu, 22 Aug 2002 11:38:16 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:14246 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319368AbSHVPiP>; Thu, 22 Aug 2002 11:38:15 -0400
Date: Thu, 22 Aug 2002 08:42:13 -0700
From: Greg KH <gregkh@us.ibm.com>
To: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>
Cc: Hanna Linder <hannal@us.ibm.com>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: PCI Cleanup
Message-ID: <20020822154213.GB30158@us.ibm.com>
References: <74760000.1029977971@w-hlinder> <20020822115025.B2502-100000@localhost.my.domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020822115025.B2502-100000@localhost.my.domain>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.4.20-pre2 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2002 at 12:11:41PM +0200, Gérard Roudier wrote:
> 
> 
> On Wed, 21 Aug 2002, Hanna Linder wrote:
> 
> > Here is the first part of the sh port of the pci_ops
> > changes. If anyone can compile this for Sega let me
> > know if there are any problems.
> 
> The 'val' pointer is declared 'u32 *', then casted 'u8 *' or 'u16 *' if
> needed. The compiler will not warn you. But user that wants to operate on
> u8 or u16 has to cast the 'val' argument to 'u32 *' and should get a
> warning from any decent C compiler. The normal C-way for such
> 'sorry-typed' argument is 'void *val', IMO.

We are filling up a u32 here (see the previous patches), so leaving this
as a u32 * and casting for the other sizes makes sense in this
situation.

thanks,

greg k-h
