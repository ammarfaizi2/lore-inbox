Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272340AbRHXXNI>; Fri, 24 Aug 2001 19:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272341AbRHXXM6>; Fri, 24 Aug 2001 19:12:58 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:19986 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S272340AbRHXXMn>; Fri, 24 Aug 2001 19:12:43 -0400
Date: Fri, 24 Aug 2001 20:12:42 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
Cc: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        "Marc A. Lehmann" <pcg@goof.com>, <linux-kernel@vger.kernel.org>,
        <oesi@plan9.de>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <20010824221456.U981-100000@gerard>
Message-ID: <Pine.LNX.4.33L.0108242011110.31410-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2001, Gérard Roudier wrote:

> The larger the read-ahead chunks, the more likely trashing will
> occur. In my opinion, using more than 128 K IO chunks will not
> improve performances with modern hard disks connected to a
> reasonnably fast controller, but will increase memory pressure
> and probably thrashing.

Your opinion seems to differ from actual measurements
made by Roger Larsson and other people.

But yes, increasing the readahead window also increases
the chance of readahead window thrashing. Luckily we can
detect fairly easily if this is happening and use that
to automatically shrink the readahead window...

regards,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

