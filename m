Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275973AbRKMQnN>; Tue, 13 Nov 2001 11:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275265AbRKMQnD>; Tue, 13 Nov 2001 11:43:03 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:2567 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S275693AbRKMQmx>; Tue, 13 Nov 2001 11:42:53 -0500
Date: Tue, 13 Nov 2001 17:42:50 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x has finally made it!
Message-ID: <20011113174250.A15774@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.33.0111131002200.14971-100000@gurney> <20011113171836.A14967@emma1.emma.line.org> <m34rnyk511.fsf@belphigor.mcnaught.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <m34rnyk511.fsf@belphigor.mcnaught.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2001, Doug McNaught wrote:

> > Wow. That person is knowledgeable... NOT. Turning off fsync() for mail
> > is just as good as piping it to /dev/null. See RFC-1123.
> 
> Umm...  He specifically stated that it was a Very Bad Idea for
> production systems.  He simply wanted to measure general throughput
> rather than disk latency (which is a bottleneck with fsync()
> enabled). 
> 
> It's a benchmark, lighten up!  ;)

Well, he wanted to benchmark everyday use, and disk latency is also an
issue for everyday use, of course; so that's kind of pointless getting
rid of I/O and benchmarking the cache. fsync() efficiency comes into
play and wants to be benchmarked as well. How do you know if your
fsync() syncs what's needed, the whole partition, the partition's meta
data (softupdates!) or the world (all blocks)?
