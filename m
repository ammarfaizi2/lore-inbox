Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262942AbTCKPLj>; Tue, 11 Mar 2003 10:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262943AbTCKPLj>; Tue, 11 Mar 2003 10:11:39 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:22718
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262942AbTCKPLi>; Tue, 11 Mar 2003 10:11:38 -0500
Subject: Re: reducing stack usage in v4l?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, rmk@arm.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030311091934.GB20721@bytesex.org>
References: <32833.4.64.238.61.1046841945.squirrel@www.osdl.org>
	 <87u1eigomv.fsf@bytesex.org> <20030305093534.A8883@flint.arm.linux.org.uk>
	 <20030305073437.0673458e.rddunlap@osdl.org>
	 <33000.4.64.238.61.1047356833.squirrel@www.osdl.org>
	 <20030311091934.GB20721@bytesex.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047400169.19262.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 11 Mar 2003 16:29:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-11 at 09:19, Gerd Knorr wrote

> That is wrong, at least the 2k memset/call mentioned by Andrew.  There
> are lots of memset() calls, but they all are within the case switches
> for the ioctls and zero out only the structs which are used in that code
> path, so it is actually much smaller (~50 -> ~300 bytes maybe, depending
> on the ioctl).

gcc sometimes does things like allocate all the objects in case
statements at entry time. I assume its a performance win to do so.

Alan

