Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318725AbSIIRqS>; Mon, 9 Sep 2002 13:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318726AbSIIRqS>; Mon, 9 Sep 2002 13:46:18 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:51879 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318725AbSIIRqR> convert rfc822-to-8bit;
	Mon, 9 Sep 2002 13:46:17 -0400
Subject: 
To: inux-net@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Cc: "Bill Hartner" <bhartner@us.ibm.com>, davem@redhat.com,
       Robert Olsson <Robert.Olsson@data.slu.se>, jamal <hadi@cyberus.ca>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF02167993.9AD389D1-ON87256C2F.00516FAC@boulder.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Mon, 9 Sep 2002 12:50:24 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 09/09/2002 11:50:25 AM
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > "David S. Miller" wrote:
>> NAPI is also not the panacea to all problems in the world.

   >Mala did some testing on this a couple of weeks back. It appears that
   >NAPI damaged performance significantly.



>http://www-124.ibm.com/developerworks/opensource/linuxperf/netperf/results/july_02/netperf2.5.25results.htm



>Unfortunately it is not listed what e1000 and core NAPI
>patch was used. Also, not listed, are the RX/TX mitigation
>and ring sizes given to the kernel module upon loading.
The default driver that is included in 2.5.25 kernel for Intel
gigabit adapter was used for the baseline test and the NAPI driver
was downloaded from Robert Olsson's website. I have updated my web
page to include Robert's patch. However it is given there for reference
purpose only. Except for the ones mentioned explicitly the rest of
the configurable values used are default. The default for RX/TX mitigation
is 64 microseconds and the default ring size is 80.

I have added statistics collected during the test to my web site. I do
want to analyze and understand how NAPI can be improved in my tcp_stream
test. Last year around November, when I first tested NAPI, I did find NAPI
results better than the baseline using udp_stream. However I am
concentrating on tcp_stream since that is where NAPI can be improved in
my setup. I will update the website as I do more work on this.


>Robert can comment on optimal settings
I saw Robert's postings. Looks like he may have a more recent version of
NAPI
driver than the one I used. I also see 2.5.33 has NAPI, I will move to
2.5.33
and continue my work on that.


>Robert and Jamal can make a more detailed analysis of Mala's
>graphs than I.
Jamal has questioned about socket buffer size that I used, I have tried
132k
socket buffer size in the past and I didn't see much difference in my
tests.
I will add that to my list again.


Regards,
    Mala


   Mala Anand
   IBM Linux Technology Center - Kernel Performance
   E-mail:manand@us.ibm.com
   http://www-124.ibm.com/developerworks/opensource/linuxperf
   http://www-124.ibm.com/developerworks/projects/linuxperf
   Phone:838-8088; Tie-line:678-8088




