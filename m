Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261451AbSJUPxt>; Mon, 21 Oct 2002 11:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261450AbSJUPxt>; Mon, 21 Oct 2002 11:53:49 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:52916 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261451AbSJUPw3>; Mon, 21 Oct 2002 11:52:29 -0400
Subject: Re: benchmarks of O_STREAMING in 2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Padraig Brady <padraig.brady@corvil.com>
Cc: Robert Love <rml@tech9.net>, akpm@digeo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DB41002.2050204@corvil.com>
References: <1034823201.722.429.camel@phantasy>
	<1035211132.27309.131.camel@irongate.swansea.linux.org.uk> 
	<3DB41002.2050204@corvil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 17:14:17 +0100
Message-Id: <1035216857.28189.192.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-21 at 15:32, Padraig Brady wrote:
> I'm confused. Isn't this just an O_STREAM flag on open/fcntl ?
> How could it be simpler? I suppose the VM could do better than
> it currently does automatically but there is no harm in the app
> giving a hint like this thus allowing stuff to be dropped from
> the cache more aggresively?

Which bit are you streaming, what kind of things are you doing with the
data ?

Take a database table are you - accessing it sequentially with caching,
accessing it randomly without readahead or streaming it and discarding
data. All three are valid answers, for the same data, and potentially on
a per table basis in the same file.

See the fadvise proposal. O_STREAMING is basically a subset of what is
needed

