Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317385AbSFHHK1>; Sat, 8 Jun 2002 03:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317386AbSFHHK0>; Sat, 8 Jun 2002 03:10:26 -0400
Received: from niobium.golden.net ([199.166.210.90]:31702 "EHLO
	niobium.golden.net") by vger.kernel.org with ESMTP
	id <S317385AbSFHHKW>; Sat, 8 Jun 2002 03:10:22 -0400
Date: Sat, 8 Jun 2002 03:10:06 -0400
From: "John L. Males" <jlmales@yahoo.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Is there something strange going on with the ext2 Filesystem?
Message-Id: <20020608031006.1ff5a93a.jlmales@yahoo.com>
In-Reply-To: <3CFFA7DB.77DF7054@zip.com.au>
Reply-To: jlmales@yahoo.com
Organization: Toronto, Ontario - Canada
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.dQuVsvI_/VNyLF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.dQuVsvI_/VNyLF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi All,

***** Please BCC me in on any reply, not CC me.  Two reasons, I am not
on the LKML, and second I am suffering BIG time with SPAM from posting
to the mailing list.  Thanks in advance. *****

Andrew, thanks kindly for sending me a copy of your reply so I can
answer the questions.  Please see below for my comments ...

On Thu, 06 Jun 2002 11:20:11 -0700
Andrew Morton wrote in Message-ID: 3CFFA7DB.77DF7054@zip.com.au

To: "John L. Males" <jlmales@softhome.net>
From: Andrew Morton <akpm@zip.com.au>
Subject: [Fwd: Re: Is there something strange going on with the ext2
Filesystem?]
Date: Thu, 06 Jun 2002 11:20:11 -0700

> 
> 

[snip]

> 
> "John L. Males" wrote:
> > 
> > Hi,
> > 

[snip]

> 
> Don't be silly. Install spamassassin like everyone else.

Thanks, but for moment I will need to see how to implement this with
sylpheed, and best done on a upcomming fresh distribution install I
will need to do from a hybreed SuSE 6.4 I have.

> 
> > Ok, I have been having some odd, to very serious problems with the
> > ext2 file system.  The problems seemed to have started when I
> > started using the 2.4.x kernels.  Possible suspect are in the
> > 2.4.15-pre5. I had used 2.4.9-ac10, 2.4.9-ac18, 2.4.10-ac12,
> > 2.4.13-ac5 in the past and a SuSE 2.4.9 varient that was simply
> > had some odd problems, not file system related, that I used for a
> > very short one session, and short boot.
> > 
> > There are three basic issues at hand:
> > 
> >  1) e2fsck 1.19 would hang with a 2.4.x kernel.  Kernel occurred
> >  on
> > was 2.4.15-pre5, then tried 2.4.13-ac5, and 2.4.9-ac18 and these
> > two also had e2fsch hang.  No changes made, just booted to 2.2.19
> > (current at time) on same system as already had 2.4.19 with the
> > OpenWall patch and e2fsck run to completion.  I do not recall if
> > there were errors detected.  I may have notes on this, as in the
> > comsole messages, but I have to do a bit of digging.
> 
> Note that e2fsprogs is at version 1.27.  1.19 is rather old.

Correct.  Most of the major problems were a while back and then 1.19
was very current and considered the version of choice.  I have been on
1.24a for some months now and 1.24a applies to issues 3 and 4.  I have
no desire to try a 2.4.x kernel on a system I need to depend on.

> 
> If it's not a fsck bug, it's conceivably a VM problem.  More
> likely it's a lost interrupt from your disk system.

Oh, I was not suggesting it was a e2fsck bug, based on the fact of
booting the already existing 2.2.19 and making no other changes,
e2fsck ran just fine.  Suggests a kernel issue in my opinion.  As for
lost interrupt, possible, but I suspect very unlikley based on how
familar I am with my system.  VM may be a possibility, but difficult
to say.  I can offer this observation with a Linus 2.2.20 Kernel and
the OpenWall patch - when memory is stressed moderately my eMail the
passwords held by my eMail program get lost and I need to re-enter one
or both the next time access to the pop server is required.  The
program remembers the password for the current instance invoked.  I do
not store my passwords in the program. 

>  
> >   2) BIG TIME cross node problems, BIG BIG time bit map problems
> >   that
> > is either realted to the special test programs I have developed
> > for testing the kernel VM subsystem, or maybe unrelated.
> 
> Can you make these programs available?

That is possible at a future date.  The programs, scripts and
supporting logging data still need work.  I also have a few more
programs and related scripts to write to round out the test suite.  I
need to find a dynamic way for the tests to run so that the "same"
type of test can run on machines of different memory configurations,
to allow a proper comparisons of VM between machines with different
amounts of memory or Kernel Memory options in order that the essence
of a test between such differences are in fact a Apples to Apples
comparison.

The other issue I have is one of licensing.  I rather not Open Source
the programs for the simple fact I have no desire to allow closed
Operating System software to have the fruits of OS QA/Testing skills
on such a basic OS element.  I have not had the time to think this out
as the test programs I have written still have various technical
metrics considerations to be thought out.  When I have the programs in
good shape, I will be happy to request thoughts/comments how to make
the tools available for Linux Kernel developers to test and inmprove
the VM subsystem.
  
> 
> >  Bottom line I
> > had real serious problems after this e2fsck wherein many files
> > were lost or say the "ps" name entry no longer pointed to the "ps"
> > program, but say the Free Pascal compiler.  There were a number of
> > these messes and so I have since moved back to the 2.2.x kernel
> > series.  There had been "smaller scale" problems like these, but
> > not with cross linked/duplicae nodes or the like with other 2.4.x
> > kernels before 2.4.15-pre5.  I therefore feel there is a problem
> > sitting about that may not have been addressed yet.  I have no
> > notes on this as these problems were with the root file system and
> > I had no ability to hold the messages and try to copy the, at
> > times, several hundred, numbers, messages.  For my other mounts I
> > can as I have XFree up at that time and can cut and past the
> > console messages into an editor and save the messages and all.
> 
> Sounds like hardware, and/or a buggy driver which wasn't buggy
> in 2.2.

For the record it is the Buslogic driver, and based on the same
hardware used for a variety of OS's via drive caddies, I have to
suggest the issue is neitehr hardware or driver related.  These
problems had definite relationships to which Kernel I was using.

> 
> How many systems have you been able to reproduce this on?

One hardware system, same Linux drive, many different Kernels I had
compiled and had available via LILO.  There is a plan once I have the
time to test this on the prime hardware system I use, and also a
second system that happenes to be a Dual SMP CPU.  Just at moment I
have not had enough time.  I know this is silly, but if the
distributions pooled resources for save a dedicated VM testing
activity, I be happy to dedicate all my time to the VM testing issues.
 Problem is I need to pay for my food, rent, cats and some other very
modest living expenses.  I have every reality the distributions would
not pool for such an expense, but just mention it in case my
assumption is incorrect.

>  
> >  3) I am starting to see a parallel even not that I have been
> >  using
> > the 2.2.19/2.2.20 kernel for a number of months now.  The parallel
> > is when the file system gets full, I will skip how this happens
> > but it does frequently in what things I do, either the next boot
> > of the system or the next scheduled e2fsck reults in various
> > bitmap, wrong group, directory counts, etc.  The number of times
> > this has happened is more than suggestive of a problem.
> 
> I can well believe that.  We've had several ENOSPC bugs, and
> they were (hopefully) fixed in kernels which are later than
> the ones you've been testing.

I need some clarification here.  First can someone explain what is
ENOSPC?  I am technical, I have seen this term used in the patch
summaries, but have no idea what it is.  I am techncial, but not a
kernel expert, so it is ok to be brief enough to allow me to
understand concepts and some technical aspects.  I do not believe I
need the very detailed technical explaination, unless there is a
strong opinion of those in the know otherwise.

Second calrification, I have to assume these ENOSPC bug fixes have
been effected in the > 2.4.14 kernels.  What I am not sure of is in
the 2.2.20 Kernel, it is current and are there some outstanding 2.2.20
ENOSPC bugs?

> 
> >  I currently do not have the
> > time or a "current" mainstream release of Linux to try testing my
> > theory on this without risking my one and only Linux day to day
> > use system.  I am trying to find time and current distribution I
> > can download over 56K modem line to do such a test.  I aslo need
> > to see if my VM tests are a factor, as in when the kernel is
> > stressed in the VM context, it has secondary negative effects. 
> > Not to mention seeing what progress the VM subsystem has made.  My
> > last check with 2.4.15-pre5 was ok, but still many problems.
> 
> 2.4.14/2.4.15 VM was pretty rough.  Suggest you grab a current
> vendor kernel or 2.4.19-pre10.

Agree those kernels were fairly rought, as real world experience
tought me.  Right now I ahave to say I am 2.4.x gun shy for my primary
Linux system.

Hence my desire, but short of time, to get a more current
distribution, free up or buy another hard drive, and do the extensive
testing on that isolated system just to see if beyond the obvious VM
issues that may or may not still exist, if there are file
system/Kernel stability issues.

I suspect I need to cross check this against a few different
distributions to confirm the results are the same across the board. 
One thing to do a test with distribution A because it is easier and
smaller to get and install.  Then install and run with my distribution
of choice, B, only to find out there is some distribution specific
issues that cause filesystem corruption.  One thing to do a test with
distribution A because it is easier and smaller to get and install. 
Then install and run with my distribution of choice, B, only to find
out there is some distribution specific issues that cause filesystem
corruption.

For sure I will need to test a few different kernel versions,
including some of the "problem" ones I suspect, in order to validate
results and progress.  That implies a need to create a base test
install image that can be reinstalled after each test to ensure the
same baseline reference of tests are used.

I also need to run the same tests on FreeBSD and OpenBSD as there
seems to be a general opinion that these BSD varients handle VM much
better at this time.  If that is in fact the case then the automated
test programs and scripts I have developed with demonstrate this or
where these BSD systems may or may not behave better under the various
VM contitions that can exist.  

Can one now see and begin to appreciate why some much time and effort
is required, even if one has created automated test cases.  To add to
this, I only have one hardware configuration.  Not a big deal for me,
but I will need to have a sense of at least the amount of memory on
the system impact to such basic test case objectives.  Now if there
were 2, 3, etc machines of the exact same "test" configuration then
the same tests could be carried out in parallel and with much less
lapsed time.  No, the machines need not match my system.  They would
need to match the "targeted" test conditions/assumptions.  I need to
do more research and discussion to determine the "technical"
requirements, conditions and number "base" conditions/tests required. 
This also goes back to the test programs I have created, that have to
either be tweaked, changed, or additional programs developed to ensure
the proper testing and metrics are tested, measured and compariable
between different the "established" variables of the tests.

I will stop there.  I started my days of testing in OS as well as
compiler testing.  I now have a  background with 12+ years of
QA/Testing experience.  I recall last October on this mailing list
where VM issues were being discussed yet again.  There were some very
good thoughts and comments made at the time.  One was something to
effect of a testing "GOD" I think was mentioned and the person making
the comments suspected no such type of person existed.  I recall the
postings were about 16/17 Oct 2001 on the LKML, in case someone wants
to review that round of VM discussions.  NO, I will not suggest I am
such a Testing GOD.  I was tempted to indicate that what was believed
not possible to create test cases for was in fact possible.  That was
the motivation for me writing the VM test programs I have created.  I
will skip the rational of why it is possible as many on the LKML
suggest it is not possible.  I really think the Kernel team needs some
QA/Testing people.  We QA/Testing people do have a different, but very
helpful way of looking at things developers generally do not have the
time for.  Even us QA/Testing people run out of time for what we need
and want to test.  Software keeps getting more complicated and able to
handle a bigger range of elements.  That fact is puttting great
pressure on many software code bases, not just the Kernel.     

>  
> >   4) Now in past few days I had a case where the system was shut
> >   down
> > normally,  Then started again next day for a few hours of very
> > light activity and shut down again normally,  Then the next
> > startup there are group/directory count problems, and bitmap
> > problems.  All after two clean shutdowns and no mount/device full
> > conditions during any of these prior sessions.
> 
> That's too easy.  Again, busted hardware, memory or driver.

Sorry, with all due respect I again have to disagree.  I have tracked
the issues and the timing of common elements too long to think it is
hardware.  As far as driver goes, possible, it is software, or its
interaction with the "larger" aspects of the Kernel.  So assuming the
issues is not hardware (memory is hardware) realted then we are back
to the Kernel as the drivers are part of the Kernel code.

I would have to question how one can make such a conclusion?  On what
facts is such an answer based?  Again I have to make mention of the
fact of how Kernel verions make a difference.  What I have forgoton to
mention, which is possible, is a cascade effect.  In the cascade
effect, "bad" code has corrupted the file system, and no matter how
"correct" the code using the file system is going forward, the
"damage" has been done and needs a "clean" slate.  Hence my need to
test on a seperate and known "clean" isolated install, and then the
determinations of facts can be made.  I am very well aware what I have
suggested here is hard to believe.  I have made basic and regular
observations that suggest what I have experienced may be a problem. 
What is needed is a focused and formal effort to test and determine
under strictly "controlled" conditions if the problems I have
experienced can be recreated or not, or if other problems are
discovered that may or may not be realted to what issues I have
observed on my system.  That is the essense of what needs to be done.

I posted my thoughts based on casual, yet very focused, observations -
firstly in case there were "know" issues, that could say with
confidence yes know that problem, yes it is fixed.  In that case it is
very easy to test and confirm.  Beyond that, matters become grey very
quickly due to the number of variables involved.  I am very good at
QA/Testing.  If there is a problem, and I have the time and resources,
I WILL find the issues and I WILL be able to document them and how to
duplicate them.

What may or may not be welcome is even after such effort is put in to
find the "formula" to duplicate an issue is if those that need to look
at the problem have the time and resources to recreate the problem so
that they can develop a fix.  That assumes someone like me has not
made some sort of oversight that results in the developer being unable
to recreate the bug.  Such situations can add additional duty cycles
and test peoples patience.

>  
> > In conclusion, I think there needs to be some more formalized and
> > specific QA/Testing testing of file systems.  The conditions to be
> > tested needs to bacome a formal and routine part Linux kernel
> > testing.
> 
> The vendors do a lot of testing.  (pretty lame testing IMO, but
> they do their best ;))

I then repeat two thoughts.  One in this eMail and one I have stated
in the past.  Then maybe it is time to "pool" the vendor resources for
testing the Kernel as it would be a win win for everyone, vendors,
users, and corporate users.  As the Kernel reaches or tries to reach
the "next" level, the QA/Testing effort increases orders of magnitude
to fulsh out what will be more difficult to find bugs, yet bugs if not
found will hold the kernel back from reaching the "next" level of
acceptance.  I have personally found the "vendor" kernels to be more
unstable that the "stock" kernel, but that is my personal observations
and experiences.  I know others have expressed much different
experiences.  All I can suggest is the extent in such a difference of
opinion at the community/user level is suggestive that there are
problems on both sides of fence.  That implies a need to try to bring
things closer together before the different problems/solutions creates
too many varients that will make the "merging" back an overwhelming
task.  I have seen this sort of pattern too many times in the past,
and it costs big time money and man hours.

> 
> >  I realize it can be time consuming, but there can be "creative"
> >  ways
> > and techniques applied to ease the effort and automate the process
> > to a great extent I am sure.
> 
> Automation doesn't help for much but regression testing.  Because
> you're always running the same test.  The most valuable test lab
> is the people who use this software daily, and report stuff.

I am sorry I have to disagree in this point.  Yes, your point is true
to a certian extent.  It is actully quite possible to flush out and
create test cases, manual and/or automated to find many of the
widespread/generic bugs.  Automation is very helpful as it is far more
efficient and provides consistant tests, ergo results that can be more
informative to comparing.  This is where I think maybe the Kernel
Development Community needs to learn that they need QA/Testing people,
who may not know how to code or write Kernel code, but clearly
understand the technical and functional OS requirements to be able to
create the needed tests.  Formal software testing requires at least as
much time and resources as development of the software code, and it is
generally know that in fact QA/Testing of softare requires more time
and resources than that required for development of the code.  .  Ad
hoc/beta testing is not a replacement for formal testing.  Manual
tests will always exist for any number of reasons.  Automated tests
can auctually be created more often than many peole believe.  Case in
point, how can a VM subsystem be benchmarked, or even coded if there
are no specific controlled test suites that isolate the VM subsystem. 
All other system functions (disk i/o other than for VM functions
included) and factors do not encroach to the point of allowing the
test suite conditions to actually be objective?  I need no answer, I
am just asking the question for the purpose of really thinking about
it.  I have seen many tests for the VM subsystem used, and with all
due respect, that are more often subjective than objective or
interfeer with the ability of the VM subsystem to perform without
competing with other system functions.  The specific issues some
installations have expereinced during last year are excellent examples
of the lack of test conditions that could of simulated many of those
conditions if the time and effort was allowed and spent on developing
test cases and "scripts" to test the conditions.  For the moment I do
not want to get into that discussion here.  That is not to suggest I
am the last word on the matter, just that the point has to be
demonstrated in fact.

Maybe I will be able to show one or two examples of such facts.  I am
human and I do make mistakes.   So I am not the last word on this by
any means, but I know I am not alone in what I think.  What is needed
to move forward is to demonstrate this in practice.  That is why I
have taken the time to develop a good foundation of tests and
supporting programs to test the VM subsystem.  I have not made much
noise or otherwise of that fact or effort I have been making.  The
reason is simple, I need facts, and that implies I need a seperarte
system to do this on to better control the variables and hence to
facts that can be concluded fromt the tests.  I have had little time
to do the testing and develop the test cases (automation, all be it is
well automated thus far, some tests can take several hours) ensure the
test cases self reference to account for a number of hardware based
variables, and there are a number of kernels to test and compare
results with.  No, not every version of the Kernel needs testing at
this point of time, but still there are at least 3-4 in each of the
2.2.x and 2.4.x series.  I can tell you I have seen the same test on
same machine vary from a couple hours to well beyond 12 hours between
different kernel versions I have tested.  The tests have alreay a part
built in where a "baseline" is established to determine how much
overhead is created overall, with logging of the specifics, so the
excessive overhead elements can be identified, and thereofore
evaluated.  

> 
> >  From my ongoing experiences the ext2 file
> > system with regard to device/file system full conditions, using
> > different block sizes, inode density configurations, and kernel
> > stress conditions are key starting elements in such a ongoing
> > sanity check of the kernel.  I would expect all the other file
> > systems to be put throught the generic file system tests as well
> > as in combination with their own specific file system
> > configurations/options.  I happened not to take the defaults and
> > therefore these may not have been tested at all or not very well
> > tested for any file system, not just the ext2 file system.
> 
> Please send a detailed bug report which will enable a developer to
> reproduce these problems.

Yes, very important request.  I am very well aware of that need and
its importance.  Now lets see of I will be able to reproduce the
problem.  The purpose of the original eMail as again mentioned in this
reply, was to at least give a heads up there may be an issue.  I know
for me it will be some time before I can determine if the problem can
be recreated, unless of course soeone proposes an alternate means to
the time and resources issues I have.  At least if people speak up
saying umm, having this odd behavious and yes others express the same,
then at least we know there is a problem.  Duplicating it, and some
problems are hard to duplicate, then becaomes the next focus in the
process.  Usually be trying to identify common factors and control
those factors to see if they have any impact of manifesting the
problem.

>  
> > I would like to trust Linux with its file system management, as I
> > can tell you first hand The Other OS has big time problems, on a
> > routine basis with thw two primary file systems it uses.  I know
> > from first hand experience, BIT TIME.  I can tell you I am not
> > your average user, and I know there are many very large
> > installations that have used Linux under what are believed
> > stressful and demanding uses over several hours.  All I can tell
> > you is for some reason I seem to break the general 80/20 rule more
> > often and my uses of systems tend to be more a 70/30 or 60/40
> > split.
> > 
> > For that reason I seem to encounter and find by "accident" more
> > problems than others in my day to day use of systems.  I will not
> > tell you what happens when I actually try to test and break
> > software to validate its design/stability/duty cycles.
> 
> You sound like a useful chap.  Please send those detailed bug
> reports.  (But please verify them on a different machine first).


As you can tell from my mindset and points that is what I intend to
do.  Just wish there was more formal structure to the Kernel process
that maybe is able to catch such issues that are very elusive.

>  
> > ...
> > ==================================================================
> > Please BCC me by replacing yahoo.com after the "@" as follows"
> > TLD =         The last three letters of the word internet
> > Domain name = The first four letters of the word software,
> >               followed by the last four letters of the word
> >               homeless.
> 
> softless.net ain't registered.   ihbt.
> 
> -


==================================================================


"Boooomer ... Boom Boom, how are you Boom Boom" Boomer 1985 -
February/2000

Again if I did not make sense in some part of my reply please feel
free to ask for clarification.  It is late and my mind is starting to
fade.


Regards,

John L. Males
Willowdale, Ontario
Canada
08 June 2002 03:10



==================================================================
***** Please BCC me in on any reply, not CC me.  Two reasons, I am not
on the LKML, and second I am suffering BIG time with SPAM from posting
to the mailing list.  Thanks in advance. *****


Please BCC me by replacing yahoo.com after the "@" as follows"
TLD =         The last three letters of the word internet
Domain name = The first four letters of the word software,
              followed by the first four letters of the word
              homeless.
My appologies in advance for the jumbled eMail address
and request to BCC me, but SPAM has become a very serious
problem.  The eMail address in my header information is
not a valid eMail address for me.  I needed to use a valid
domain due to ISP SMTP screen rules.
--=.dQuVsvI_/VNyLF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iEYEARECAAYFAj0BrdgACgkQsrsjS27q9xYH9gCgn+gyH0fJS50BZR6+FUlwb1fS
rMAAmwUMW1NkTDvMUPoy8dkSeCjaiDGr
=W3gm
-----END PGP SIGNATURE-----

--=.dQuVsvI_/VNyLF--

