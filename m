Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263308AbTCNI57>; Fri, 14 Mar 2003 03:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263300AbTCNI57>; Fri, 14 Mar 2003 03:57:59 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:53004 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263308AbTCNI55>;
	Fri, 14 Mar 2003 03:57:57 -0500
Date: Fri, 14 Mar 2003 00:57:32 -0800
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?Bj=F6rn?= Fahller <bjorn@netinsight.se>
Cc: Oleg Drokin <green@linuxhacker.ru>, alan@redhat.com,
       linux-kernel@vger.kernel.org, zubarev@us.ibm.com
Subject: Re: [2.4] Multiple memleaks in IBM Hot Plug Controller Driver
Message-ID: <20030314085731.GE3084@kroah.com>
References: <20030313204556.GA3475@linuxhacker.ru> <200303140934.44245.bjorn@netinsight.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200303140934.44245.bjorn@netinsight.se>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14, 2003 at 09:34:44AM +0100, Björn Fahller wrote:
> On Thursday 13 March 2003 21.45, Oleg Drokin wrote:
> 
> Below, why allocating 2 bytes on heap (str1,) only to non-conditionally free 
> it a few lines further down? Why not keep the two bytes on stack instead? It 
> also seems like a bad idea to strncopy/strcat 1 byte long strings.

Like I previously said, this whole function is a bad dream.  Look at
what is now in 2.5, all of this nonsense is now gone.

thanks,

greg k-h
