Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262674AbTDAQlm>; Tue, 1 Apr 2003 11:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262675AbTDAQlm>; Tue, 1 Apr 2003 11:41:42 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:44808 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262674AbTDAQlk>; Tue, 1 Apr 2003 11:41:40 -0500
Date: Tue, 1 Apr 2003 17:52:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Roman Zippel <zippel@linux-m68k.org>, Joel Becker <Joel.Becker@oracle.com>,
       bert hubert <ahu@ds9a.nl>, Greg KH <greg@kroah.com>,
       Andries.Brouwer@cwi.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Wim Coekaerts <Wim.Coekaerts@oracle.com>
Subject: Re: 64-bit kdev_t - just for playing
Message-ID: <20030401175256.A19660@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Roman Zippel <zippel@linux-m68k.org>,
	Joel Becker <Joel.Becker@oracle.com>, bert hubert <ahu@ds9a.nl>,
	Greg KH <greg@kroah.com>, Andries.Brouwer@cwi.nl,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Wim Coekaerts <Wim.Coekaerts@oracle.com>
References: <Pine.LNX.4.44.0303281031120.5042-100000@serv> <20030328180545.GG32000@ca-server1.us.oracle.com> <Pine.LNX.4.44.0303281924530.5042-100000@serv> <20030331083157.GA29029@outpost.ds9a.nl> <Pine.LNX.4.44.0303311039190.5042-100000@serv> <20030331172403.GM32000@ca-server1.us.oracle.com> <Pine.LNX.4.44.0303312215020.5042-100000@serv> <1049149133.1287.1.camel@dhcp22.swansea.linux.org.uk> <Pine.LNX.4.44.0304010137250.5042-100000@serv> <1049208134.19703.12.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1049208134.19703.12.camel@dhcp22.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Tue, Apr 01, 2003 at 03:42:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 03:42:24PM +0100, Alan Cox wrote:
> We need to default to 12:20 for char but where the 20 is actually
> defaulting to 0000xx so we don't get extra minors for any device
> that hasnt been audited for it

Why do we need a split at all?  Just make it reserve a 8k range which
is the same as the old major.  No problem with wasting space then.

