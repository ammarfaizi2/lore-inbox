Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131305AbRAZOpF>; Fri, 26 Jan 2001 09:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131559AbRAZOo4>; Fri, 26 Jan 2001 09:44:56 -0500
Received: from gate.in-addr.de ([212.8.193.158]:28680 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S131305AbRAZOou>;
	Fri, 26 Jan 2001 09:44:50 -0500
Date: Fri, 26 Jan 2001 15:44:47 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: James Sutherland <jas88@cam.ac.uk>
Cc: "David S. Miller" <davem@redhat.com>,
        Matti Aarnio <matti.aarnio@zmailer.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re:   hotmail not dealing with ECN
Message-ID: <20010126154447.L3849@marowsky-bree.de>
In-Reply-To: <20010126124426.O2360@marowsky-bree.de> <Pine.SOL.4.21.0101261344120.11126-100000@red.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.3i
In-Reply-To: <Pine.SOL.4.21.0101261344120.11126-100000@red.csi.cam.ac.uk>; from "James Sutherland" on 2001-01-26T13:44:53
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001-01-26T13:44:53,
   James Sutherland <jas88@cam.ac.uk> said:

> > > A delayed retry without ECN might be a good compromise...
> > _NO!!!!!_
> Why? As it stands, I have ECN disabled. It's staying disabled until I know
> it won't degrade my Net access.

First, you are ignoring a TCP_RST, which means "stop trying". 

You would have to retry a connection with a new source port. How do you handle
cases where the application explicitly bound the socket to a specific source
port / source IP ?

Caching whether the site is able to speak ECN or not is also suboptimal if the
local site is opening lots of outgoing connections, like a proxy server. (Of
course, memory has gotten cheap)

_And_ it is solving the problem on the wrong end.

Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Perfection is our goal, excellence will be tolerated. -- J. Yahl

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
