Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268527AbTCAOBF>; Sat, 1 Mar 2003 09:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268551AbTCAOBF>; Sat, 1 Mar 2003 09:01:05 -0500
Received: from pdbn-d9bb8683.pool.mediaWays.net ([217.187.134.131]:58638 "EHLO
	citd.de") by vger.kernel.org with ESMTP id <S268527AbTCAOBC>;
	Sat, 1 Mar 2003 09:01:02 -0500
Date: Sat, 1 Mar 2003 15:11:14 +0100 (CET)
From: Matthias Schniedermeyer <ms@citd.de>
To: Dan Kegel <dank@kegel.com>
cc: Joe Perches <joe@perches.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel source spellchecker
In-Reply-To: <3E60474C.1060304@kegel.com>
Message-ID: <Pine.LNX.4.44.0303011503590.29947-101000@korben.citd.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811740-117829526-1046527874=:29947"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811740-117829526-1046527874=:29947
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 28 Feb 2003, Dan Kegel wrote:

> Joe Perches wrote:
> > On Wed, 2003-02-26 at 22:59, Dan Kegel wrote:
> >
> >>Since the main remaining feature before release of the 2.6
> >>kernel is fixing all the remaining spelling errors,
> >>this patch seems appropriate.
> >
> >
> > Who let the comedian in? :o
>
> At first I was jokeing, but what the heck, I figured I'd run
> it.  Here are the mispelled words that occur in five
> or more files and that lookd like real misspellings to my eye.
> The list contains some words that are ok in British usage;
> I don't have a British spellchecker (that I know how to use).
>
> Perhaps some eagr Perl monger can (after removing the British-ok
> words!) contribute a spellcorrect-kernel program that takes
> in a liste of known misspellings + corrections, and applies
> them to the commments in all kernel source files...
> - Dan

I've no spelling knowledge, so the list of spellcorrections must be made
by someone else. But i can volunteer the perl-snippet to correct the
files. :-)

See attachment.

The programm uses this file-format:
correct=false1,false2,false3...

As there are many ways to false-write a word i think this is the best(tm)
solution to get readable file.
:-)

I've only done a "quick-debug", so there might still be errors in the
program. (Including spelling-bugs ;-) )

- snip -
Usage: spell_fix.pl <options>, where valid options are
    --help            # this message :-)
    --file <file>     # File(s) to be checked
    --dir <dir>       # Directory(s) to be checked (recursive!)
    --spell-file      # File with the correction-list
    --debug           # Debugging-Messages
- snip -




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated,
cryptic, powerful, unforgiving, dangerous.


---1463811740-117829526-1046527874=:29947
Content-Type: APPLICATION/x-perl; name="spell-fix.pl"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0303011511140.29947@korben.citd.de>
Content-Description: 
Content-Disposition: attachment; filename="spell-fix.pl"

IyEvdXNyL2Jpbi9wZXJsIC13Cgp1c2Ugc3RyaWN0Owp1c2UgR2V0b3B0OjpM
b25nOwp1c2UgdmFycyBxdyAoCgkgICAgICRkZWJ1ZwoJICAgICAlc3BlbGwg
JHNwZWxsX3JlCgkgICAgICRzcGVsbF9maWxlCgkgICAgIEBpbnB1dF9maWxl
cyAkaW5wdXRfZmlsZQoJICAgICBAaW5wdXRfZGlycyAgJGlucHV0X2RpcgoJ
ICAgICAkZGlyICRwYXRoCgkgICAgKTsKdXNlIHN1YnMgcXcgKAoJICAgICBp
bml0X2NvbW1hbmRsaW5lIHVzYWdlCgkgICAgKTsKc3ViIGNoZWNrX2ZpbGUo
JCk7Cgppbml0X2NvbW1hbmRsaW5lOwoKIyAtLSBSZWFkIGZpbGUgd2l0aCB0
aGUgc3BlbGxpbmdzIC0tCiMgRmlsZS1Gb3JtYXQKIyBjb3JyZWN0LXdvcmQ9
ZmFsc2UsZmFsc2UsZmFsc2UuLi4Kb3BlbiAoRkksICRzcGVsbF9maWxlKSBv
ciBkaWUgKCJDYW4ndCBvcGVuIFwiJHNwZWxsX2ZpbGVcIiIpOwp3aGlsZSAo
PEZJPikgewogIGNob21wOwogIHByaW50ICJJbnB1dC1MaW5lOiAkX1xuIiBp
ZiAoJGRlYnVnKTsKICBteSAoJGNvcnJlY3QsICRmYWxzZV9zKSA9IHNwbGl0
ICgvXHMqPVxzKi8sICRfLCAyKTsKICBmb3JlYWNoIG15ICRmYWxzZSAoc3Bs
aXQgKC9ccyosXHMqLywgJGZhbHNlX3MpKSB7CiAgICBwcmludCAiRml4OiBc
IiRmYWxzZVwiIC0+IFwiY29ycmVjdFwiXG4iIGlmICgkZGVidWcpOwogICAg
JHNwZWxseyRmYWxzZX0gPSAkY29ycmVjdDsKICB9Cn0KY2xvc2UgKEZJKTsK
IyAtLSBFbmQgLS0KCiMgLS0gQ3JlYXRlIHRoZSByZWd1bGFyIGV4cHJlc3Np
b24gLS0KbXkgQHRlbXBfc3BlbGw7CmZvcmVhY2ggbXkgJGtleSAoc29ydCB7
JGIgY21wICRhfSBrZXlzICVzcGVsbCkgewogICMgRm9yIGtleXMgZW5kaWcg
d2l0aCBhICJcdyJvcmQtY2hhcmFjdGFyIHdlIGFkZCBhICJcYiJvdW5kYXJ5
LgogICMgT3RoZXJ3aXNlIHdlIGdldCBpbnRvIHRyb3VibGUgd2l0aCB3b3Jk
cyB0aGF0IGJlZ2luIHRoZSBzYW1lIGJ1dCBhcmUgbG9uZ2VyCiAgbXkgJHBv
c3RmaXggPSAka2V5ID1+IC9cdyQvID8gJ1xiJyA6ICcnOwoKICBwdXNoIEB0
ZW1wX3NwZWxsLCAiXFEka2V5XEUkcG9zdGZpeCIKfQokc3BlbGxfcmUgPSBq
b2luICgiXHwiLCBAdGVtcF9zcGVsbCk7CnByaW50ICJTcGVsbF9yZTogJHNw
ZWxsX3JlXG4iIGlmICgkZGVidWcpOwojIC0tIEVuZCAtLQoKIyBDaGVjayBm
aWxlcywgaWYgc3BlY2lmaWVkCmlmICgkI2lucHV0X2ZpbGVzID49IDApIHsK
ICBmb3JlYWNoICRpbnB1dF9maWxlIChAaW5wdXRfZmlsZXMpIHsKICAgIHBy
aW50ICJDaGVja2luZyBmaWxlOiBcIiRpbnB1dF9maWxlXCJcbiIgaWYgKCRk
ZWJ1Zyk7CiAgICBjaGVja19maWxlICgkaW5wdXRfZmlsZSk7CiAgfQp9Cgoj
IENoZWNrIGRpcnMsIGlmIHNwZWNpZmllZAppZiAoJCNpbnB1dF9kaXJzID49
IDApIHsKICBmb3JlYWNoICRpbnB1dF9kaXIgKEBpbnB1dF9kaXJzKSB7CiAg
ICBwcmludCAiQ2hlY2tpbmcgZGlyOiBcIiRpbnB1dF9kaXJcIlxuIiBpZiAo
JGRlYnVnKTsKICAgICZ0cmF2ZXJzZSgkaW5wdXRfZGlyKTsKICB9Cn0KCiMg
V2hlbiB0aGVyZSB3YXMgbm8gZmlsZSBhbmQvb3IgZGlyIGFyZ3VtZW50KHMp
IHRoZW4gcHJvY2VzcyBldmVyeXRoaW5nIGZyb20gY3VycmVudCBkaXIKaWYg
KCQjaW5wdXRfZmlsZXMgPT0gLTEgJiYgJCNpbnB1dF9kaXJzIC0xKSB7CiAg
cHJpbnQgIk5vIGRpci9maWxlcyBzcGVjaWZlZCBjaGVja2luZyBhbGwgZmls
ZXMgaW4gdGhlIGRpciBhbmQgc3ViZGlyc1xuIiBpZiAoJGRlYnVnKTsKICAm
dHJhdmVyc2UoIi4iKTsKfQoKc3ViIGluaXRfY29tbWFuZGxpbmUgewogIG15
ICRoZWxwb3B0ICA9IDA7CiAgJGRlYnVnICAgICAgID0gMDsKICAkc3BlbGxf
ZmlsZSAgPSAic3BlbGwtZml4LnR4dCI7CiAgQGlucHV0X2ZpbGVzID0gKCk7
CiAgQGlucHV0X2RpcnMgID0gKCk7CgogIG15ICRyZXN1bHQgPSBHZXRPcHRp
b25zKAoJCQkgICdoZWxwIScgICAgICAgICA9PiBcJGhlbHBvcHQsCgkJCSAg
J3NwZWxsLWZpbGU9cycgID0+IFwkc3BlbGxfZmlsZSwKCQkJICAnZmlsZT1z
JyAgICAgICAgPT4gXEBpbnB1dF9maWxlcywKCQkJICAnZGlyPXMnICAgICAg
ICAgPT4gXEBpbnB1dF9kaXJzLAoJCQkgICdkZWJ1ZyEnICAgICAgICA9PiBc
JGRlYnVnLAoJCQkgKTsKCiAgdXNhZ2UoKSBpZiAkaGVscG9wdDsKfQoKc3Vi
IHVzYWdlIHsKICBwcmludCA8PCJFT0YiOwpVc2FnZTogJDAgPG9wdGlvbnM+
LCB3aGVyZSB2YWxpZCBvcHRpb25zIGFyZQogICAgLS1oZWxwICAgICAgICAg
ICAgIyB0aGlzIG1lc3NhZ2UgOi0pCiAgICAtLXNwZWxsLWZpbGUgICAgICAj
IEZpbGUgd2l0aCB0aGUgY29ycmVjdGlvbi1saXN0CiAgICAtLWZpbGUgPGZp
bGU+ICAgICAjIEZpbGUocykgdG8gYmUgY2hlY2tlZAogICAgLS1kaXIgPGRp
cj4gICAgICAgIyBEaXJlY3RvcnkocykgdG8gYmUgY2hlY2tlZCAocmVjdXJz
aXZlISkKICAgIC0tZGVidWcgICAgICAgICAgICMgRGVidWdnaW5nLU1lc3Nh
Z2VzCkVPRgogIGV4aXQoMCk7Cn0KCnN1YiB0cmF2ZXJzZSB7CiAgbG9jYWwo
JGRpcikgPSBzaGlmdDsKICBsb2NhbCgkcGF0aCk7CgogIHVubGVzcyAob3Bl
bmRpcihESVIsICRkaXIpKSB7CiAgICB3YXJuICJDYW4ndCBvcGVuICRkaXJc
biI7CiAgICBjbG9zZWRpcihESVIpOwogICAgcmV0dXJuOwogIH0KICBmb3Jl
YWNoIChyZWFkZGlyKERJUikpIHsKICAgIG5leHQgaWYgJF8gZXEgJy4nIHx8
ICRfIGVxICcuLic7CiAgICAkcGF0aCA9ICIkZGlyLyRfIjsKICAgIGlmICgt
ZCAkcGF0aCkgeyAgICAgICAgICMgYSBkaXJlY3RvcnkKICAgICAgJnRyYXZl
cnNlKCRwYXRoKTsKICAgIH0KICAgIGVsc2lmICgtZiBfKSB7ICAgICAgICAj
IGEgcGxhaW4gZmlsZQogICAgICBjaGVja19maWxlICgkcGF0aCk7CiAgICB9
CiAgfQogIGNsb3NlZGlyKERJUik7Cn0KCnN1YiBjaGVja19maWxlKCQpIHsK
ICBteSAkZmlsZSA9IHNoaWZ0OwogIG15ICRjb250ZW50OwoKICBvcGVuIChG
SSwgJGZpbGUpIG9yIHJldHVybjsKICAkY29udGVudCA9IGpvaW4gKCIiLCA8
Rkk+KTsKICBjbG9zZSAoRkkpOwoKICAjIENvcnJlY3Qgc3BlbGxpbmcuIFll
cyB0aGlzIGlzIG9ubHkgYSBzaW5nbGUgc3Vic3RpdHV0aW9uLiA6LSkKICBp
ZiAoJGNvbnRlbnQgPX4gcy9cYigkc3BlbGxfcmUpLyRzcGVsbHskMX0vZWcp
IHsKICAgIHByaW50ICJGYWxzZSBzcGVsbGluZ3MgZm91bmQuIEZpbGU6IFwi
JGZpbGVcIlxuIiBpZiAoJGRlYnVnKTsKICAgICMgQW5kIHdyaXRlIGJhY2sg
dGhlIGZpbGUuCiAgICBvcGVuIChGTywgIj4kZmlsZS50bXAiKSBvciBkaWUg
KCJDYW4ndCBvcGVuIGZpbGUgXCIudG1wJGZpbGVcIiBmb3Igd3JpdGluZyIp
OwogICAgcHJpbnQgRk8gJGNvbnRlbnQ7CiAgICBjbG9zZSAoRk8pOwoKICAg
IHJlbmFtZSAoIiRmaWxlIiwgIiRmaWxlLnRtcDIiKSBvciBkaWUgKCJDYW4n
dCByZW5hbWUgXCIkZmlsZVwiIC0+IFwiJGZpbGUudG1wMlwiIik7CiAgICBy
ZW5hbWUgKCIkZmlsZS50bXAiLCAiJGZpbGUiKSBvciBkaWUgKCJDYW4ndCBy
ZW5hbWUgXCIkZmlsZS50bXBcIiAtPiBcIiRmaWxlXCIiKTsKICAgIHVubGlu
ayAoIiRmaWxlLnRtcDIiKSBvciBkaWUgKCJDYW4ndCB1bmxpbmsgXCIkZmls
ZS50bXAyXCIiKTsKICB9CiAgZWxzZSB7CiAgICBwcmludCAiTm8gZmFsc2Ug
c3BlbGxpbmdzIGZvdW5kLiBGaWxlOiBcIiRmaWxlXCJcbiIgaWYgKCRkZWJ1
Zyk7CiAgfQp9Cg==
---1463811740-117829526-1046527874=:29947--
