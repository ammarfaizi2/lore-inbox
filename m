Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267599AbRGNJMu>; Sat, 14 Jul 2001 05:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267603AbRGNJMl>; Sat, 14 Jul 2001 05:12:41 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:59914 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S267590AbRGNJMa>;
	Sat, 14 Jul 2001 05:12:30 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: linux-kernel@vger.kernel.org, linux-admin@vger.kernel.org
Subject: Re: ORBS blacklist is BROKEN (deliberately)... 
In-Reply-To: Your message of "Sat, 14 Jul 2001 11:55:06 +0300."
             <20010714115506.G18653@mea-ext.zmailer.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 14 Jul 2001 19:12:23 +1000
Message-ID: <10249.995101943@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jul 2001 11:55:06 +0300, 
Matti Aarnio <matti.aarnio@zmailer.org> wrote:
>  dig @63.92.26.236 any *.relays.orbs.org.
>
>will show you A and TXT data FOR WILDCARD ('star') ENTRY!
>AND ONLY FROM THAT ONE SERVER OUT OF THEM ALL!

http://www.e-scrub.com/orbs/ is the key.  "Ronald F. Guilmette"
<rfg@monkeys.com> sent this message to spam lists.  Anybody still using
ORBS for lookups can expect to get random mail bounces.


To: spamtools@abuse.net
Subject: [spamtools] IMPORTANT!!!  ORBS USERS PLEASE TAKE NOTE
Date: Thu, 12 Jul 2001 14:52:46 -0700
From: "Ronald F. Guilmette" <rfg@monkeys.com>

IMPORTANT!!!

IF YOU ARE CONFIGURED TO MAKE REFERENCES TO ANY ORBS.ORG `LIST' ZONE
I STRONGLY SUGGEST THAT YOU DISCONTINUE DOING SO IMMEDIATELY, IF NOT
SOONER.  FAILURE TO DO SO MAY RESULT IN SERIOUS IMPARMENT OF YOUR
E-MAIL INFLOW.

This is a public service announcement for those sites that are still
configured to perform lookups against the any or all of the following
former (and now defunct) ORBS zones:


        inputs.orbs.org
        outputs.orbs.org
        relays.orbs.org
        delayed-outputs.orbs.org
        spamsources.orbs.org
        spamsource-netblocks.orbs.org
        manual.orbs.org

As a courtesy to Alan Brown (owner and operator of ORBS.ORG), I agreed
last year to allow one of my name servers (E-SCRUB.COM) to become one
of 11 name servers for the orbs.org zone.  I agree to this because the
each of the `list' subdomains noted above was in fact a separate zone
of its own, separate and different from the base `orbs.org' zone, which
itself contained very few DNS records.

My agreement with Alan was ONLY to act as a secondary name server (one
of eleven) for the base orbs.org zone.  Because of normal DNS client-side
caching, and because of the small number of DNS records involved, I knew
for certain at the time that having my name server be one of 11 secondaries
for the base orbs.org zone would involve very little expenditure of band-
width on my part.

The situation changed dramatically however with Alan's disabling of the
subzones mentioned above.  (This occured sometime last month.  I'm not
exactly sure of the date.)  When disabling the `list' subzones, Alan
apparently just removed any mention of these subzones/subdomains from
the base orbs.org zone file.

Because of the way Alan disabled the former ORBS list zones, my name
server is now shouldering (at least) 1/11th of the total world-wide
DNS queries that are still being made against both the base orbs.org
zone and also against all of the former ORBS `list' subzones.  This
may not sound like a lot, but in fact ot DOES represent a substantial
and noticable drain on the small amount of bandwidth I have.  I should
note also that when I briefly turned on query logging in my name server
recently, I found that over 2,000 sites world wide are still making
frequent and repeated references to the former ORBS list subzones,
presumably as they attempt to check each e-mail message coming into
their mail servers.

I simply do not have the kind of bandwidth necessary to support all of
this pointless and utterly wasteful traffic.  I've asked Alan multiple
times to remove my name server from the list of authoratative name servers
for the orbs.org zone, and each time he has made up some new implausible
excuse.  Alan's dog may indeed have eaten his homework, but his excuses
just aren't believable anymore.  (He has had plenty of time to take care
of this.  I first requested him to remove my server on June 7th, 2001,
and I have re-requested that he do that several times since.  Each time
he has either failed to respond or else had presented me with some new
implausible excuse.)

I've considered various solutions to this problem, but none of them seem
particularly easy for me.  I could certainly relocate my name server, called
E-SCRUB.COM, to a different IP address, but for all I know, the DNS query
traffic might just follow the name, rather than the IP address, so then I'd
be right back where I started.  It would also be a major pain in the ass for
me to get an new IP for other reasons.  I have already tried setting up
NS records in _my_ copy of the orbs.org zonefile (on my name server) for
all of the subzones mentioned above, and pointing all of those NS records
at 127.0.0.1 (local loopback address) but for reason I don't fully under-
stand, that hasn't stopped the DNS query flood to my name server either.

I'm sure that there are a number of other possible convoluted solutions to
this problem, e.g. creating a new `host' record in DNS (and with NSI) and
then re-jiggering all of the records for my many other domains so that the
primary name servers for those are listed as being the new `host', but this
seems like a lot more work than I should have to go to just because Alan
refuses to do the decent thing and because so many sites have been so horribly
lax in removing references to the now long defunct ORBS list zones.

In light of all this, I've decided to just use a trivial and brute-force
approach to stopping all of this DNS query traffic from being sent to my
name server.  As of 9 PM tonight (Pacific Daylight Time) my name server
will be configured to answer ALL `A' record queries regarding ANY name
within the orbs.org domain with an affirmative response and with the IP
address value `127.0.0.1'.  Each such response will carry an extremely
long TTL, in order to insure that further queries regarding the same name
will be put off as long as possible into the indefinite future.

An exception will be made, of course, for `A' record queries relating to
`www.orbs.org', which my name server will contine to identify as being
located at 202.61.250.235.

The implications of my plan for sites still attempting to use the orbs.org
zones for e-mail filtering purposes should be evident.  From 9 PM PDT tonight
all such sites will begin to reject (at least) an estimated 1/11th of their
incoming e-mail, at random.  The portion of incoming e-mail given this
treatment by these sites may in fact increase, over time, as I also intend
to delete all other NS (name server) records from my copy of the orbs.org
zone file, leaving only my server listed as being authoritative for this
zone.  (I'm actually not sure what effects this will have as the root
server will still contain a completely list of all 11 current registered
name server for the zone.)

Complaints, flames, and lawsuit threats resulting from the DNS change that
I will make to name server this evening should be directed to Alan Brown,
whose new/current e-mail address seems to be <alanb@dms.digistar.com>,
and/or to your own local mail administrator.

Finally, allow me to recommend to all mail administrators reading this that
tonight's change will provide you with what I believe will be a more than
compelling incentive to select some new and different source of open relays
data.  At the present time, there are at least four such services available
to the general public.


Regards,
Ron Guilmette
<rfg@monkeys.com>


P.S.  I wish that I could recommend one of the four active open relays listing
services above the others, but one of them refuses to accept automated sub-
missions, two of the others don't seem to even answer their e-mail, and the
final one has recently blacklisted my own non-open mail server, simply be-
cause I made the small mistake of manually replying to one of their own
auto-replies that was sent in response to a prior message that I had sent
them to nominate some open relays I knew about.

When and if a responsive and intelligently-run public open relays listing
service become available, I'll certainly be among the first to use it and to
recommend it.


