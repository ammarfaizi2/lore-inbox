Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269489AbRH0W04>; Mon, 27 Aug 2001 18:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269541AbRH0W0r>; Mon, 27 Aug 2001 18:26:47 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:32401 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S269489AbRH0W0g>;
	Mon, 27 Aug 2001 18:26:36 -0400
Date: Mon, 27 Aug 2001 23:26:48 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Oliver.Neukum@lrz.uni-muenchen.de,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Message-ID: <526972105.998954808@[169.254.198.40]>
In-Reply-To: <Pine.SOL.4.33.0108272332230.1537-100000@sun2.lrz-muenchen.de>
In-Reply-To: <Pine.SOL.4.33.0108272332230.1537-100000@sun2.lrz-muenchen.de>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Monday, 27 August, 2001 11:38 PM +0200 
Oliver.Neukum@lrz.uni-muenchen.de wrote:

> How do you measure cost of
> replacement ?

See previous mail with cost of E. However, this
is broken w.r.t. differential speed of consumption
by tasks, and as Daniel points out, if the system
works as he's designed/designing, the key will be
sizing readahead sufficiently intelligently that
drops happen infrequently anyway. If it works like
TCP windows, it need not be particularly intelligent
(very punitive, but infrequent), and we can do
the tweaks of what packets to drop (cf RED in TCP)
later.

My point w.r.t. penalizing fast consumers is that
negative feedback in a control system isn't necessarily
bad.

--
Alex Bligh
