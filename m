Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263147AbTCNAcF>; Thu, 13 Mar 2003 19:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263149AbTCNAcF>; Thu, 13 Mar 2003 19:32:05 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:44555 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263147AbTCNAcF>;
	Thu, 13 Mar 2003 19:32:05 -0500
Date: Thu, 13 Mar 2003 16:31:44 -0800
From: Greg KH <greg@kroah.com>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org, zubarev@us.ibm.com
Subject: Re: [2.4] Multiple memleaks in IBM Hot Plug Controller Driver
Message-ID: <20030314003143.GA1787@kroah.com>
References: <20030313204556.GA3475@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030313204556.GA3475@linuxhacker.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13, 2003 at 11:45:56PM +0300, Oleg Drokin wrote:
> Hello!
> 
>    There seem to be memleak convert_2digits_to_char() function that is triggered
>    during normal operations.
>    Also I think there are some memleaks on error exit paths
>    ebda_rsrc_controller()
>    All of this is addressed by below patch.
>    2.5 seems to have totally different version of this code (and no
>    convert_2digits_to_char() function at all for example).

Yes, the 2.5 version should be backported to 2.4.  There have been a
number of error patch fixes in the 2.5 version, care to make up a patch?

>    Found with help of smatch + enhanced unfree script.

The 2.5 changes were found with smatch too :)

thanks,

greg k-h
