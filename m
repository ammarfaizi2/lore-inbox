Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030510AbVIBNsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030510AbVIBNsr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 09:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbVIBNsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 09:48:47 -0400
Received: from yakov.inr.ac.ru ([194.67.69.111]:54196 "HELO yakov.inr.ac.ru")
	by vger.kernel.org with SMTP id S1751319AbVIBNsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 09:48:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=Hv/aTsUhBKYI6kZhPcIaefnlfUV/+zPQe6skV+hD5DOA5FeRk8DEdDvNSUxQqb6W8PZVbl42n5VlGW1nRbR4OYtqdaENtAvXi6HvvcOSHpbN5Gc7Xieu6neUwC8ChjB0YLSnNysjX9h/B+X+BnXKWp7D1kwp4kO2qeHZZCXarSk=;
Date: Fri, 2 Sep 2005 17:48:07 +0400
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: John Heffner <jheffner@psc.edu>
Cc: Ion Badulescu <lists@limebrokerage.com>,
       "David S. Miller" <davem@davemloft.net>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Possible BUG in IPv4 TCP window handling, all recent 2.4.x/2.6.x kernels
Message-ID: <20050902134807.GB12617@yakov.inr.ac.ru>
References: <Pine.LNX.4.61.0509011713240.6083@guppy.limebrokerage.com> <20050901.154300.118239765.davem@davemloft.net> <Pine.LNX.4.61.0509011845040.6083@guppy.limebrokerage.com> <2d02c76a84655d212634a91002b3eccd@psc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d02c76a84655d212634a91002b3eccd@psc.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> If you overflow the socket's memory bound, it ends up calling 
> tcp_clamp_window().  (I'm not sure this is really the right thing to do 
> here before trying to collapse the queue.)

Collapsing is too expensive procedure, it is rather an emergency measure.
So, tcp collapses queue, when it is necessary, but it must reduce window
as well.

Alexey
