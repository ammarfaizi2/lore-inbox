Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267375AbUG2AJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267375AbUG2AJq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 20:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267369AbUG2AJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 20:09:34 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:55987 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S267370AbUG2AI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 20:08:56 -0400
Date: Wed, 28 Jul 2004 17:08:37 -0700
From: Chris Wedgwood <cw@f00f.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Peter Chubb <peter@chubb.wattle.id.au>,
       viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: stat very inefficient
Message-ID: <20040729000837.GA24956@taniwha.stupidest.org>
References: <233602095@toto.iv> <16648.10711.200049.616183@wombat.chubb.wattle.id.au> <20040728154523.20713ef1.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728154523.20713ef1.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 03:45:23PM -0700, David S. Miller wrote:

> "find . -type f" is probably the most often run command somewhere in
> a shell pipeline when I'm doing kernel work and grepping around.

Just How bad is it for you?  I just tested stat on my crapbox and for
a short path 1M stats takes 0.5s and for a longer path (30 bytes or
so) 2.8s.

Sure, it's always nice to make things faster, but given that whatever
else I'm doing with this information will most likely be *many* times
slower I'm not sure if reducing it to zero would make any appreciable
difference here...


  --cw
