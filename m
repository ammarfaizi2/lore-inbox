Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261322AbSJYK1r>; Fri, 25 Oct 2002 06:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261325AbSJYK1r>; Fri, 25 Oct 2002 06:27:47 -0400
Received: from boden.synopsys.com ([204.176.20.19]:35744 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S261322AbSJYK1r>; Fri, 25 Oct 2002 06:27:47 -0400
Date: Fri, 25 Oct 2002 12:33:52 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [SECURITY] CERT/CC VU#464113, SYN plus RST/FIN
Message-ID: <20021025103352.GE3512@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Florian Weimer <fw@deneb.enyo.de>,
	linux-kernel@vger.kernel.org
References: <87vg3qq4ec.fsf@deneb.enyo.de> <20021025101311.GD3512@riesen-pc.gr05.synopsys.com> <87smyuq0vu.fsf@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87smyuq0vu.fsf@deneb.enyo.de>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 12:16:37PM +0200, Florian Weimer wrote:
> >> +		if(th->rst || th->fin)
> >> +			goto discard;
> >>  
> >>  		if(th->syn) {
> >>  			if(tp->af_specific->conn_request(sk, skb) < 0)
> >
> > You mean to place the check below "if(th->syn)", don't you?
> 
> No, of course not. :-) That's the whole point of the patch.
> A SYN is not a SYN if it comes together with a RST.

Oh, i see :)

