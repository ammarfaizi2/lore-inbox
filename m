Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271400AbTHRLvd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 07:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271407AbTHRLvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 07:51:33 -0400
Received: from pizda.ninka.net ([216.101.162.242]:33516 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271400AbTHRLvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 07:51:31 -0400
Date: Mon, 18 Aug 2003 04:44:19 -0700
From: "David S. Miller" <davem@redhat.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: willy@w.ods.org, alan@lxorguk.ukuu.org.uk, carlosev@newipnet.com,
       lamont@scriptkiddie.org, davidsen@tmr.com, bloemsaa@xs4all.nl,
       marcelo@conectiva.com.br, netdev@oss.sgi.com, linux-net@vger.kernel.org,
       layes@loran.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030818044419.0bc24d14.davem@redhat.com>
In-Reply-To: <20030818133957.3d3d51d2.skraw@ithnet.com>
References: <20030728213933.F81299@coredump.scriptkiddie.org>
	<200308171509570955.003E4FEC@192.168.128.16>
	<200308171516090038.0043F977@192.168.128.16>
	<1061127715.21885.35.camel@dhcp23.swansea.linux.org.uk>
	<200308171555280781.0067FB36@192.168.128.16>
	<1061134091.21886.40.camel@dhcp23.swansea.linux.org.uk>
	<200308171759540391.00AA8CAB@192.168.128.16>
	<1061137577.21885.50.camel@dhcp23.swansea.linux.org.uk>
	<200308171827130739.00C3905F@192.168.128.16>
	<1061141045.21885.74.camel@dhcp23.swansea.linux.org.uk>
	<20030817224849.GB734@alpha.home.local>
	<20030817223118.3cbc497c.davem@redhat.com>
	<20030818133957.3d3d51d2.skraw@ithnet.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Aug 2003 13:39:57 +0200
Stephan von Krawczynski <skraw@ithnet.com> wrote:

> Can you please give us a striking example of a widespread application where
> current behaviour is a requirement or at least a very positive thing?

[ I've been waiting what seems like centuries for someone
  to even consider talking about source address selection,
  alas I have to bring it up myself :( ]

I'll responsd by asking questions of you.

Do you know how source address selection works when the user tries to
connect to a remote location yet doesn't specify a specific source
address to use?

Once you understand source address selection, the next thing
you need to do is:

1) consider how you might want to make that configurable
   by the user
2) what the default behavior should be
3) what kind of ARP behavior is necessary in order for
   these various configurations to work
