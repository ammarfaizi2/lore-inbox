Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261281AbSJCXEr>; Thu, 3 Oct 2002 19:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261412AbSJCXEq>; Thu, 3 Oct 2002 19:04:46 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:33293 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261281AbSJCXEq>;
	Thu, 3 Oct 2002 19:04:46 -0400
Date: Thu, 3 Oct 2002 16:07:28 -0700
From: Greg KH <greg@kroah.com>
To: Kevin Corry <corryk@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
Subject: Re: EVMS Submission for 2.5
Message-ID: <20021003230728.GF2289@kroah.com>
References: <02100216332002.18102@boiler> <20021002224343.GB16453@kroah.com> <02100316563708.05904@boiler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02100316563708.05904@boiler>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 04:56:37PM -0500, Kevin Corry wrote:
>      http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/evms/runtime/linux-2.5/

Heh, looks like you ran the thing through Lindent without looking at the
output.  Lindent is a great place to start, but it does generate lines
like the following which you will probably want to fix up by hand
(unless you really want to try to maintain things like this...)

						volume_group->
						    volume_list[AIXppent->
								lv_index -
								1]->
						    le_to_pe_map_mir1
						    [le_number].
						    pe_sector_offset = offset;

oh, here's another one that's even messier:

							volume_group->
							    volume_list
							    [AIXppent->
							     lv_index -
							     1]->
							    le_to_pe_map_mir2
							    [le_number].
							    pe_sector_offset =
							    offset;

You also have a number of local variables that use InterCaps.

But, 80 column rants aside, the code looks much better, thank you for
cleaning it up.

thanks,

greg k-h
