Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267383AbUHWFxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267383AbUHWFxM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 01:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267410AbUHWFxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 01:53:12 -0400
Received: from herkules.viasys.com ([194.100.28.129]:34775 "HELO
	mail.viasys.com") by vger.kernel.org with SMTP id S267383AbUHWFxL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 01:53:11 -0400
Date: Mon, 23 Aug 2004 08:53:08 +0300
From: Ville Herva <vherva@viasys.com>
To: linux-kernel@vger.kernel.org
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: [OT] vmware, 2.6 kernel and altgr key (Re: 2.6.8.1-mm2 breaks vmware)
Message-ID: <20040823055308.GP23741@viasys.com>
Reply-To: vherva@viasys.com
References: <20040820131825.GI23741@viasys.com> <20040820144304.GF8307@viasys.com> <20040820151621.GJ23741@viasys.com> <20040820114518.49a65b69.akpm@osdl.org> <20040821062927.GM23741@viasys.com> <20040821134918.GA1585@devserv.devel.redhat.com> <20040821190027.GQ3024@viasys.com> <20040821190730.GA25932@devserv.devel.redhat.com> <20040822143112.GB24092@vana.vc.cvut.cz> <20040822211903.GO23741@viasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040822211903.GO23741@viasys.com>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux herkules.viasys.com 2.4.27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 12:19:03AM +0300, you [Ville Herva] wrote:
> 
> *) Apart from that even 3.2.1 2242 does not fix the altgr key that does not
>    seem to work with 2.6 new input system. 

For the record, Petr found a solution for this one, too.

For whatever reason, xev gives the following for altgr (right alt) these
days:

    state 0x0, keycode 113 (keysym 0xfe03, ISO_Level3_Shift), same_screen YES,
                       ^^^

Adding 
 
  xkeymap.keycode.113 = 312

into /etc/vmware/config or into the per guest .cfg lets altgr work again
with vmware 3.2.1.


-- v -- 

v@iki.fi

