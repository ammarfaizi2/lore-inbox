Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266271AbTAINPX>; Thu, 9 Jan 2003 08:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266411AbTAINPX>; Thu, 9 Jan 2003 08:15:23 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:7339 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S266271AbTAINPW>;
	Thu, 9 Jan 2003 08:15:22 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Tupshin Harper <tupshin@tupshin.com>
Date: Thu, 9 Jan 2003 14:23:52 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: oops while vmware-config.pl with kernel 2.4.21-pre2
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <CBD40FC6247@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8 Jan 03 at 22:04, Tupshin Harper wrote:
> I'm going to forward this to the vmware folks, but there's a decent 
> chance they are not totally to blame:

> Jan  8 21:40:41 fussbudget kernel: EIP:    0010:[skb_clone+407/448] 
> Trace; e4f287e3 <[vmnet]VNetHubReceive+57/a7>

Can you try to update your vmware with 
ftp://platan.vc.cvut.cz/pub/vmware/vmware-any-any-update24.tar.gz ?

But I do not think that it will fix your problem. I'm not able to
find how it could happen, except if skb with NULL skb->end (and though
NULL skb_shinfo()) was passed to the callback registered by dev_add_pack()...
But it should not happen...
                                            Thanks,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
