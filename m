Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130901AbQLLLcX>; Tue, 12 Dec 2000 06:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131103AbQLLLcN>; Tue, 12 Dec 2000 06:32:13 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:530 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S130901AbQLLLb7>; Tue, 12 Dec 2000 06:31:59 -0500
Message-ID: <3A360577.CC5E776E@idb.hist.no>
Date: Tue, 12 Dec 2000 12:01:11 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: no, da, en
MIME-Version: 1.0
To: elenstev@mesatop.com, linux-kernel@vger.kernel.org
Subject: Re: UP 2.2.18 makes kernels 3% faster than UP 2.4.0-test12
In-Reply-To: <Pine.Linu.4.10.10012120529110.970-100000@mikeg.weiden.de> <00121122173600.03488@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole wrote:
[...]
> Simple question here, and risking displaying great ignorance:
> Does it make sense to use make -jN where N is much greater than the
> number of CPUs?

No, but it makes sense to have N at least one more than the number of
cpus,
if you have the memory.  This because your processes occationally
will wait for disk io, and this time may then be utilized to
run the "extra" task.  But don't overdo it, as you get less disk
cache this way.  make -j3 seems to be fastest on my 2-cpu machine
with 128M ram.

Helge Hafting
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
