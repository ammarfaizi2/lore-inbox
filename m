Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312696AbSDONwk>; Mon, 15 Apr 2002 09:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312704AbSDONwj>; Mon, 15 Apr 2002 09:52:39 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:828 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S312696AbSDONwf>; Mon, 15 Apr 2002 09:52:35 -0400
Date: Mon, 15 Apr 2002 08:52:16 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200204151352.IAA43591@tomcat.admin.navo.hpc.mil>
To: elenstev@mesatop.com, "Calin A. Culianu" <calin@ajvar.org>
Subject: Re: Cannot compile mandrake 8.2 Kernel
In-Reply-To: <1018475564.17571.10.camel@spc.esa.lanl.gov>
Cc: linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Very hard to read; how about doing the next one in ASCII?:

> <html>
> <blockquote type=3Dcite class=3Dcite cite>All,<br><br>
> At the last HPCMP SIG meeting (Security Implementation Group Meeting
> 26-28 2002 at AFRL, Kirtland AFB, NM) Peer to Peer computing was
> discussed, lead by Rodger Johnson.&nbsp; This resulted in a tasker at
> several levels, which has been assigned to me to lead.&nbsp; <br><br>
> As such a P2P direction or focus has been defined for the HPCMP (see
> below), as well a high level timeline for deliverables from this
> takser.&nbsp; From the SIG minutes furnished by Joe Molnar the following
> individuals had expressed an interest in participating in the P2P effort
> within our community.&nbsp; They need to discuss this with their
> management before committing:<br><br>
> Greg Fulmer<br>
> Ricky Green<br>
> Mike Donovon<br>
> Mark Radleigh<br><br>
> Has anyone of you been able to discuss this yet with your management
> chain, and can you now make a commitment?<br><br>
> In addition there were several volunteers:<br>
> Jessie Pollard<br>
> Vern Staats<br>
> Nathan Bill <br>
> Dana Allen<br><br>
> Can you four still participate in this effort?<br><br>

I can as far as other work may intrude. (see discussion of:

1. K5 1.2.3
2. batch kerberos support

> In addition the original P2P effort at the program office
> included:<br><br>
> Phil Dykstra<br><br>
> We&nbsp; also hope to tap personnel at the HPCMO, and of course the
> information from the lead HPCMP CSA POC, Mark Heck so we as a team can
> provide the asked for deliverables, are the two of you available to
> participate?<br><br>
> FYI form the SIG minutes:<br><br>
> <b>-Peer-to-Peer computing Rodger Johnson<br>
> DoD going down the path of P2P because it is the hot thing.&nbsp; Input
> on P2P computing was requested from the SIG, at large.&nbsp; It appears
> that while e-mail can be examined some viruses (in attachments) have been
> noted to be coming through P2P connections.&nbsp; It was noted that while
> P2P could be a useful application for DoD to use, it is open to hackers
> as it exists.<br><br>
> Mark Heck spoke on the dangers of P2P; i.e. how do we check for it?&nbsp;
> ISS will only pick up the default ports; need to write a plugin for
> Nessus.<br>

Not likely to happen. P2P can appear as normal HTTP traffic. The only
thing unique about it is that the servers are in a "listen" mode. If the
server is unknown (and assuming any port > 1024) then you can only assume
it is "not allowed". Actual identification is not reliable due to:

1. possible encryption
2. the higher level protocol is unknown
3. the higher level protocol requires an access key
4. It may not allow local host connections
5. It may not allow the host the scan is being run from

Unfortunately, some utilities DO use ports > 1024 (console support on
E-10000 for instance uses ports around 32000).

Been doing some research....

> Suggestion made to establish the policy to eliminate it. (Yeager.)&nbsp;
> Suggestion also made that the applications look for open port.
> (Samios).&nbsp; Pollard states that it is VPN connection and may not even
> see it.&nbsp; Bottom line-there are a lot of concerns.<br>
> Rodger indicated that we could form a working group to discuss P2P
> security threats and issues and may also possibly address the positive
> things that could be done with P2P.&nbsp; <br>
> Volunteers include Greg Fulmer, Ricky Green, Mike Donovon, Mark
> Radleigh.&nbsp; While these guys indicated that they would like to
> participate they needed to talk to their management for the
> commitment.&nbsp; In addition there were several defined candidates:
> Jessie Pollard, Vern Staats, Nathan Bill and Dana Allen as a
> minimum.<br><br>
> <i>[Comment from Joe Molnar-My thoughts are that there are several levels
> to address the problem. HPCMP policy, Local Site policy, firewall policy,
> DREN site and NAP router filters, HPC CERT rules for intrusion detection,
> CSA team tools to identify such traffic, and local site techniques for
> identifying such traffic.&nbsp; Suggest that the group tries to address
> what can be done at these and other levels that may exist.]<br><br>
> </i></b>Based on this, the HPCMP P2P subgroup of the SIG team will
> provide guidance and direction in the form of several white papers, i.e.
> the deliverables.&nbsp; In addition, we hope to work with the ASD C3I
> study of P2P, and at least provide input to the RAND study and report
> forthcoming next year.<br><br>
> The deliverables are:<br><br>
> 1.&nbsp; White paper on how P2P can be useful to the HPC communities
> within DoD<br>
> 2.&nbsp; White paper on how security, or lack thereof, with P2P can be
> bolstered and weaknesses mitigated<br>
> <x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>This would
> include a DREN - Internet policy on P2P type traffic, as well as
> recommended site policies for firewalls and filters and which
> applications to allow and not allow<br>
> 3. White paper on P2P traffic analysis and patterns, i.e. signatures
> which could be used in NIDS and any kind of security assessments to
> include HPCMP CSAs and perhaps provide input to ISS for additional
> scanning signatures<br><br>
> <i>The HPCMP P2P focus and direction is:<br><br>
> The DoD at the ASD C3I level is investigating the use of P2P on DoD
> systems interconnected using DoD WANs with Internet access.&nbsp; How can
> the HPCMP take advantage of this technology, and leverage the usefulness
> of distributed computing, and low tech file sharing and instant
> messaging.&nbsp; Weakness in this technology are many, but with
> mitigation some applications, ASD C3I has a great interest in the Groove
> Network
> (<a href=3D"http://www.groove.net/" eudora=3D"autourl">http://www.groove.net=
> /</a>)
> P2P solution, using encryption and authentication may be of great to use
> to our user base.&nbsp; How can accept this type of access, with less
> then Kerberos/SecurID authentication and identification?&nbsp; Would this
> put the HPCMP security posture at risk?&nbsp;&nbsp;&nbsp; Which
> applications and/or types of P2P applications should be used at HPCMP
> SRCs, on DREN, at sites (each may have very different interests)?&nbsp;
> How can the HPCMP contribute to the ASD C3I effort, or influence how P2P
> should be used throughout the DoD?&nbsp; Can we identify all the
> weaknesses, and devise suitable mitigations to the bigger risks?&nbsp;
> Are there ways to look for the &quot;bogus&quot; P2P applications during
> CSAs?&nbsp; How can the &quot;bogus&quot; applications be limited,and how
> - via policies, scans, better system administration?<br><br>

By not allowing users direct access:

	The user app must make a local request for a P2P from a socket
	generator daemon. This daemon must them establish the proper
	remote connection, and then pass a socket back to the requesting
	process. This socket should not communicate directly with the
	remote host. The socket should talk to a "service" daemon to provide
	possible encrypted communication with a remote "service" daemon
	that provides the equivalent support for the remote application.

	The "socket" daemon must act in a manner similar to the portmap
	utility, in that it requires a request to a known service. Before
	connections to that service are permitted, proper authentication
	would be enforced. Encryption requirements should be negotiated.
	Then the "socket" daemon can spawn the "service" daemon which carries
	out the negotiated encryption/decryption and passes the data to
	the user application via an anonymous socket.

	Registration occurs when the user/batch/cron starts the user service
	process. That user service process would then register with the
	"socket" daemon in order to recieve/send reqests to a remote host.
	The process (or daemon..) must be capable of using the users TGT
	to authenticate remote connections.

	This way the host/user can be authenticated between the hosts, and
	still maintain security control over the facility. It also provides
	an obvious audit and control point, yet is still permits the user
	to put up almost any kind of P2P service. Real time audio/video
	might have delays due to encrypt/decrypt or other handling done
	by the service daemons.

This doesn't address problems of buffer overflow attacks implemented by
the users "application", or the restriction of data leak (unless only
the same user identity is permitted access... though leaks can still occur,
they are no greater risk than already existing leaks).

> </i>If interested and time permits, perhaps we could get a demo copy of
> Groove (since this is of particular interest to ASD C3I), and look at all
> of its strengths and weaknesses.&nbsp; Additionally we could look at
> existing P2P applications in use today over DREN, at DREN sites, and used
> at HPCMP SRCs, and provide a risk analysis.&nbsp; During the initial
> kickoff teleconference, additional directions or modification of the
> above focus can be discussed.<br><br>

Haven't finished digging into groove, but it wasn't mentioned in the
Oriley P2P book as supporting security. The index was empty under the
topic. Look under "trust" - Nowhere does it mention facility control
of I&A and authorization. Might just as easily look at freenet.

Every example shown does NOT perform identification and authentication.

Identity is whatever the user wants. Authentication is nonexistant.
Authorization is nonexistant - everybody is equal... (hence the peer to
peer...).

The problem is that P2P ASSUMES:

1. client and server are one "application" (not necessarily one process).
2. users have COMPLETE control over their "application".
3. users have COMPLETE authorization to release/accept data.
4. That data can contain ANYTHING - executables, images, audio, arbitrary
   files. (this is also where the winamp bug shows up - it handles web pages
   too, and does/did it incorrectly).
5. full shared data access is desired (not necessarily updates to the data).
6. data may be stored at any host, under the users credentials

> Initial short term timeline is ~4 to 5 months for the three identified
> white papers:<br><br>
> 1.&nbsp; Kick off teleconference:&nbsp; 1 May 2002 1400 EST - number to
> be provided latter this week.<br>
> &nbsp; At this kickoff (expect a one hour conversation) sub-taksers and
> sub-teams should be formed to address the deliverables and P2P
> focus<br><br>
> 2.&nbsp; Update teleconference 22 May 2002 1400 EST - Anticipate a one
> hour teleconference<br>
> &nbsp; Updates from each team, and new sub-taskers if=20
> identified<br><br>
> 3.&nbsp;&nbsp;&nbsp; Update teleconference 19 June 2002 1400 EST -
> Anticipate a one hour teleconference<br>
> &nbsp; Updates from each team, and new sub-taskers if=20
> identified<br><br>
> 4.&nbsp; First cut draft of each of the three identified white papers COB
> 26 July 2002<br><br>
> 5.&nbsp; Update teleconference 15 August 2002 1400 EST - Anticipate a one
> hour teleconference<br>
> &nbsp; Updates from each team on the white papers<br>
> <br>
> 6.&nbsp; Final White papers due COB 30 August 2002<br><br>
> If possible the HPCMP would also like to participate at the DoD
> level.&nbsp; If this can be arranged, the timelines may change and the
> overall tasker may be much bigger.<br><br>
> I have attached a copy of the HPCMP P2P position paper and P2P Powerpoint
> presentation sent via our chain to Rodger Johnson, Dr. Frank Mello, Dr.
> Holland, DDR&amp;E to ASD C3I.<br>
> <x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab><br><br>
> Very Respectfully,<br>
> John E. Samios<br>
> ............................................................................=
> ..........<br>
> High Performance Computing Modernization Program Office<br>
> Defense Research Engineering Network (DREN) Operations Manager<br>
> Contractor (Honeywell Technology Solutions Inc.)<br>
> Voice:&nbsp;&nbsp; (703) 812-8205 x 4023<x-tab>&nbsp;&nbsp;</x-tab><br>
> Cell:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (703) 622-1666<br>
> Fax:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (703) 812-9701<br>
> E-mail:&nbsp; jsamios@hpcmo.hpc.mil&nbsp; <br>
> Web paging:
> <a href=3D"http://www.hpcmo.hpc.mil/john.html"=
>  eudora=3D"autourl">http://www.hpcmo.hpc.mil/john.html</a><br>
> Text messaging: 7036221666@mobile.att.net <br>
> ............................................................................=
> ..........
> </blockquote><br>
> </html>
> 

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
