Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317539AbSFKU5I>; Tue, 11 Jun 2002 16:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317540AbSFKU5I>; Tue, 11 Jun 2002 16:57:08 -0400
Received: from h189n1fls22o974.telia.com ([213.64.79.189]:18679 "HELO
	tippex.localdomain") by vger.kernel.org with SMTP
	id <S317539AbSFKU5H> convert rfc822-to-8bit; Tue, 11 Jun 2002 16:57:07 -0400
X-Mailer: exmh version 2.5_20020515 01/15/2001 with nmh-1.0.4
To: DervishD <raul@pleyades.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: QoS on incoming data 
In-Reply-To: Message from DervishD <raul@pleyades.net> 
   of "Tue, 11 Jun 2002 21:30:47 +0200." <3D064FE7.mail1Z311DBJT@viadomus.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Tue, 11 Jun 2002 22:57:01 +0200
From: Anders Eriksson <aeriksson@fastmail.fm>
Message-Id: <20020611205706.E3A8B470D@tippex.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You said way back that it was only wget that did hog the andbith, 
right? Assuming that you speak to the same servers all the time (i.e. 
for both the wget and non-wget cases), how about playing with the tcp 
windows? If the send and receive machines are the same, any 
difference have to come from different tcp setups. Check what 
options, if any wget and others are setting. I bet announcing a large 
receive window can folld your upstream network (your ISP's queues) 
and make the rest of the tcp timer magics run on longer control 
loops, this making it respond to changes more sluggishly.

/Anders


>>>>> On Tue, 11 Jun 2002, "DervishD" == DervishD wrote:

  DervishD> Hi all :)

  DervishD> After reading a bit of the HOWTO about traffic control
  DervishD> and advanced routing, I have a doubt about the queue
  DervishD> disciplines and traffic shaping.

  DervishD> I've seen that, except the 'ingress' qdisc (and maybe the
  DervishD> hierarchycal token bucket) all other qdisc's seem to be
  DervishD> only valid for outgoing traffic, although I suppose that
  DervishD> some of those qdisc could be easily applied to incoming
  DervishD> traffic.

  DervishD> But the key point is that: I think that the better way of
  DervishD> controlling the incoming bandwidth is the Token Bucket
  DervishD> Filter, just as the autor of the HOWTO says, but I think
  DervishD> (may be wrong here) that the TBF is only valid for
  DervishD> outgoing traffic. Moreover, if, just as the HOWTO says,
  DervishD> we set up the TBF for controlling the incoming traffic
  DervishD> at, lets say, 250kb/s for an ADSL access of 256kb/s, it
  DervishD> won't control the outgoing traffic, since the bandwidth of
  DervishD> that traffic is just 128kb/s. That is: TBF is not valid if
  DervishD> applied to both incoming and outgoing traffic, and anyway
  DervishD> I think that only controls the outgoing part.

  DervishD> Please excuse the continous questions about this subject,
  DervishD> but I'm new to this and wanting to understand a bit this
  DervishD> powerful feature.

  DervishD> Thanks in advance :) Raúl - To unsubscribe from this list:
  DervishD> send the line "unsubscribe linux-kernel" in the body of a
  DervishD> message to majordomo@vger.kernel.org More majordomo info
  DervishD> at http://vger.kernel.org/majordomo- info.html Please read
  DervishD> the FAQ at http://www.tux.org/lkml/


