Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278665AbRJSVgW>; Fri, 19 Oct 2001 17:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278666AbRJSVgM>; Fri, 19 Oct 2001 17:36:12 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:45555 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S278665AbRJSVgB>; Fri, 19 Oct 2001 17:36:01 -0400
Message-ID: <3BD09D3F.C16E423E@nortelnetworks.com>
Date: Fri, 19 Oct 2001 17:38:07 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jacques Gelinas <jack@solucorp.qc.ca>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Is writing to /dev/ramdom a security flaw (vserver project)
In-Reply-To: <20011019172309.4219c22e9a53@remtk.solucorp.qc.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jacques Gelinas wrote:
> 
> I have announced a project (see my signature) to run several virtual servers
> on a single box (single kernel as well). The vservers are real linux distribution
> running in a chroot/chbind/chcontext and capability limited environment.
> 
> While looking at the kernel we found out that writing to /dev/random is
> not controlled by any capability. We are providing a /dev/random in
> the vservers with permission 644, so it can be used.
> 
> Is this a security issue if an administrator of a vserver is allowed to write
> in /dev/random ?

My understanding is that anything written to /dev/random is stirred into the
pool without incrementing the entropy count.  Thus, it shouldn't be an issue.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
