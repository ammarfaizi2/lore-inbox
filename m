Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265707AbRF1NGX>; Thu, 28 Jun 2001 09:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265709AbRF1NGO>; Thu, 28 Jun 2001 09:06:14 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:40209 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S265707AbRF1NGK>; Thu, 28 Jun 2001 09:06:10 -0400
Date: Thu, 28 Jun 2001 15:05:32 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Rodrigo Ventura <yoda@isr.ist.utl.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: iwconfig seg-faults
Message-ID: <20010628150532.T13592@arthur.ubicom.tudelft.nl>
In-Reply-To: <lx3d8kx2gz.fsf@pixie.isr.ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <lx3d8kx2gz.fsf@pixie.isr.ist.utl.pt>; from yoda@isr.ist.utl.pt on Thu, Jun 28, 2001 at 12:34:20PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2001 at 12:34:20PM +0100, Rodrigo Ventura wrote:
> 
>         SuSE 7.1, wireless-tools-20-5, kernel 2.4.5-pre3:
> 
> /root# gdb iwconfig
> [...]
> (gdb) run wvlan0
> Starting program: /usr/bin/iwconfig wvlan0
> wvlan0    IEEE 802.11-DS  ESSID:"ISocRob"  Nickname:"Gedeao"
>           Frequency:2.437GHz  Sensitivity:1/3  Mode:Ad-Hoc  
>           Access Point: 00:00:00:00:00:00
>           Bit Rate:2Mb/s   RTS thr:off   Fragment thr:off   
>           Encryption key:off
>           Power Management:off
>           Link quality:0  Signal level:0  Noise level:0
>           Rx invalid nwid:0  invalid crypt:0  invalid misc:500
> 
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0xc22ab05c in ?? ()
> 
>         Can't get any further useful info from gdb.
> 
>         Is this a known "issue"?

Yes, recompile iwconfig against your current kernel solves the problem
(you need to put a -I flag in the wireless-tools Makefile).


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
