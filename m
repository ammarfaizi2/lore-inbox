Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132228AbRAQRTM>; Wed, 17 Jan 2001 12:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131795AbRAQRTB>; Wed, 17 Jan 2001 12:19:01 -0500
Received: from relay.dera.gov.uk ([192.5.29.49]:40284 "HELO relay.dera.gov.uk")
	by vger.kernel.org with SMTP id <S131527AbRAQRSm>;
	Wed, 17 Jan 2001 12:18:42 -0500
Message-ID: <XFMail.20010117171554.gale@syntax.dera.gov.uk>
X-Mailer: XFMail 1.4.4 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.30.0101171911010.21865-100000@shodan.irccrew.org>
Date: Wed, 17 Jan 2001 17:15:54 -0000 (GMT)
From: Tony Gale <gale@syntax.dera.gov.uk>
To: Jussi Hamalainen <count@theblah.org>
Subject: IP defrag (was RE: ipchains blocking port 65535)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 17-Jan-2001 Jussi Hamalainen wrote:
> On Wed, 17 Jan 2001, Tony Gale wrote:
> 
>> It looks like this is due to the odd way in which ipchains handles
>> fragments. Try:
>>
>> echo 1 > /proc/sys/net/ipv4/ip_always_defrag
> 
> Thanks, this seems to do the trick. Does this oddity still exist
> in 2.4?
> 

Well, I haven't found it, but there is
/proc/sys/net/ipv4/ipfrag_high_thresh
/proc/sys/net/ipv4/ipfrag_low_thresh
/proc/sys/net/ipv4/ipfrag_time

Perhaps 2.4 always defrags packets by default. Anyone confirm? This
is pretty much needed for any kind of firewall/masquerading system.

-tony



---
E-Mail: Tony Gale <gale@syntax.dera.gov.uk>
The great merit of society is to make one appreciate solitude.
		-- Charles Chincholles, "Reflections on the Art of Life"

The views expressed above are entirely those of the writer
and do not represent the views, policy or understanding of
any other person or official body.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
