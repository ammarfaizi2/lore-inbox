Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbUJZFow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbUJZFow (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 01:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUJZFou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 01:44:50 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:49163 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261667AbUJZF2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 01:28:38 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
Date: Tue, 26 Oct 2004 08:28:03 +0300
User-Agent: KMail/1.5.4
References: <20041022155048.GA16240@elte.hu> <20041025141628.GA14282@elte.hu> <33313.192.168.1.5.1098733224.squirrel@192.168.1.5>
In-Reply-To: <33313.192.168.1.5.1098733224.squirrel@192.168.1.5>
MIME-Version: 1.0
Message-Id: <200410260827.39888.vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jBefBqwjH2l4luc"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_jBefBqwjH2l4luc
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 25 October 2004 22:40, Rui Nuno Capela wrote:
> Ingo Molnar wrote:
> >> ok, i've added it and uploaded -V0.2 together with another fix: there
> >> was a scheduler recursion possible via the delayed-put mechanism using
> >> workqueues - now it's using its own separate lists and per-CPU
> >> threads.
> >
> > -V0.2 seems to behave quite well on my testboxes - i'm unable to
> > reproduce the selinux boot hang anymore.
> >
> 
> OK. RT-V0.2 boots on my laptop (P4/UP), sometimes ;)
> 
> I know that my early impressions are illusive, rather subjective, but I do
> feel overall behavior is getting worst, when regarding low-latency audio
> work with jackd -R.
> 
> To put things straight with RT-V0.2, I get trouble with much less load
> than even before.
> 
> I noticed that something is, now and then, topping the cpu to 99%, leaving
> the system to a crawl, eventually returning back to normal. Can't figure
> out who or what, just because ps or top are stalling to silence, only
> returning results after when the crawl ends, which are of no useful
> evidence. When I'm lucky enough to let top (and gkrellm) telling me
> something, it does look like that most of the time is spent on kernel mode
> (sys time) and none of the running processes are at stake. Puzzled. It's
> just like you're about to loose confidence on the procps tools.

<shameless plug>
Maybe this program will be useful. It is designed to give you
overall system statistics without the need to scan entire /proc/NNN
forest. Together with nice -20, it will hopefully not stall.

Compiled with dietlibc. If you will have trouble compiling it, binary is
attached too.

Latest version is 0.9 but it seems I forgot it in my home box :(
</shameless plug>
--
vda



--Boundary-00=_jBefBqwjH2l4luc
Content-Type: application/x-executable;
  name="nmeter"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="nmeter"

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
4IlV3ItVGIXSx0XUAAAAAA+ENP///4tF4ItV3IlF6IlV7OkV////x0XYAAAAAOvUuCAAAAAp8IlF
0ItV5Inx0+KLRcyKTdDT6AnCifHTZcyJVeSKTdCLVdzT6ot93Inx0+eLReCKTdDT6AnHifj3deSJ
fdyJ8YlV3IlF2PdlzNNl4DtV3InHd0Y7Vdx0PItFGIXAx0XUAAAAAA+Eqv7//4tN3ItF4Cn4GdGJ
TdyJyopN0NPiifGJReDT6AnCi0XciVXo0+jp7v7//ztF4Ha//03YK33MG1Xk67SJ9lWJ5Y1F+IPs
FFD/dRT/dRD/dQz/dQjoCQAAAItF+ItV/MnDkFWJ5VdWg+wwi1UUi3UIi30Mi0UQhdLHRfAAAAAA
x0X0AAAAAMdF6AAAAADHRewAAAAAiUXMiVXkiXXgiX3cD4WIAAAAOfh2UInwifr3dcyJVeCJRdjH
RdQAAAAAi3UYhfZ0G4tV4IlV6MdF7AAAAACLTRiLReiLVeyJAYlRBItV2ItN1IlV8IlN9ItF8ItV
9IPEMF5fycOQi33Mhf91DbgBAAAAMdL3dcyJRcyLRdyLVeT3dcyJVdyJRdSLReD3dcyJVeCJRdjr
k412AItF3DlF5HYwi00YhcnHRdgAAAAAx0XUAAAAAHSViXXoiUXsi1Xoi0UYi03siRCJSATpfP//
/4n2D71F5InGg/YfdVWLVeQ5Vdx3CItNzDlN4HI8i1Xci0XgK0XMG1Xkx0XYAQAAAIlF4IlV3ItV
GIXSx0XUAAAAAA+ENP///4tF4ItV3IlF6IlV7OkV////x0XYAAAAAOvUuCAAAAAp8IlF0ItV5Inx
0+KLRcyKTdDT6AnCifHTZcyJVeSKTdCLVdzT6ot93Inx0+eLReCKTdDT6AnHifj3deSJfdyJ8YlV
3IlF2PdlzNNl4DtV3InHd0Y7Vdx0PItFGIXAx0XUAAAAAA+Eqv7//4tN3ItF4Cn4GdGJTdyJyopN
0NPiifGJReDT6AnCi0XciVXo0+jp7v7//ztF4Ha//03YK33MG1Xk67SJ9gAAAAAAAAAAAAAAAAAA
AAAvcHJvYy9zdGF0AC9wcm9jL25ldC9kZXYAL3Byb2MvbWVtaW5mbwAvcHJvYy9kaXNrc3RhdHMA
MDEyMzQ1Njc4OQAgMTIzNDU2Nzg5ACBrTUdURVAAY3B1IABpbnRyAGludCAAY3R4dABjdHggAGJp
byAAcGFnZQBzaW8gAHN3YXAAcHJvY2Vzc2VzAGZvcmsAOgBNZW1Ub3RhbDoATWVtRnJlZToAQnVm
ZmVyczoAQ2FjaGVkOgBtZW0gAHRvdCAAZnJlZSAAU3dhcDoAc3dwIAAvcHJvYy9zeXMvZnMvZmls
ZS1ucgAAZmQgAGV4dGVybiAAbmNtc2ZpeHB0YmUACgAvcHJvYy92ZXJzaW9uAExpbnV4IHZlcnNp
b24gMi42LgANAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAG5tZXRlciAwLjcgYWxsb3dzIHlv
dSB0byBtb25pdG9yIHlvdXIgc3lzdGVtIGluIHJlYWwgdGltZQoKT3B0aW9uczoKY1tOXQltb25p
dG9yIENQVS4gTiAtIGJhciBzaXplLCBkZWZhdWx0IDEwCm5JRkFDRQltb25pdG9yIG5ldHdvcmsg
aW50ZXJmYWNlIElGQUNFCm1bZi90XQltb25pdG9yIGFsbG9jYXRlZC9mcmVlL3RvdGFsIG1lbW9y
eQpzCW1vbml0b3IgYWxsb2NhdGVkIHN3YXAKZgltb25pdG9yIG51bWJlciBvZiB1c2VkIGZpbGVk
ZXNjcmlwdG9ycwppW05OXQltb25pdG9yIHRvdGFsL3NwZWNpZmljIElSUSByYXRlCngJbW9uaXRv
ciBjb250ZXh0IHN3aXRjaCByYXRlCnAJbW9uaXRvciBwcm9jZXNzIGNyZWF0aW9uIHJhdGUKYltz
XQltb25pdG9yIGJsb2NrIGlvIChzd2FwIGlvKQp0W05dCXNob3cgdGltZSAod2l0aCBOIGRlY2lt
YWwgcG9pbnRzKQpkW05dCW1pbGxpc2Vjb25kcyBiZXR3ZWVuIHVwZGF0ZXMuIERlZmF1bHQgMTAw
MApoW05dCXByaW50IGhlYWRlcnMgYWJvdmUgbnVtYmVycyAoZWFjaCBOIGxpbmVzLCBkZWZhdWx0
IG9uY2UpCmxMQUJFTAlzcGVjaWZ5IGxhYmVsIGZvciBwcmV2aW91cyBpdGVtCkxMQUJFTAlzYW1l
ICsgbGFiZWwgd2lsbCBiZSBwcmludGVkIHdpdGhvdXQgc3Vycm91bmRpbmcgYmxhbmtzCnIJcHJp
bnQgPGNyPiBpbnN0ZWFkIG9mIDxsZj4gYXQgRU9MLiBUcnkgaXQgOykKAC9iaW4vc2gAAAAAAAAA
oJ8ECP////8AAAAAq58ECP////8AAAAAuZ8ECP////8AAAAAx58ECP////8AAAAA/////wAAAADA
tQQIAAAAAJqKBAiahgQI6osECG6MBAjkjAQIUocECBiIBAjaiQQItI0ECEiJBAjSjwQIFAAAAAAA
AAABelIAAXwIARsMBASIAQAASAAAABwAAAAE5///GwAAAAAEAQAAAA4IhQIEAgAAAA0FBAUAAAAu
BAQDAAAALggEAwAAAC4MBAMAAAAuEAQDAAAALhQEBwAAAC4AACgAAABoAAAA1Ob//w4CAAAABAEA
AAAOCIUCBAIAAAANBQQFAAAAhgSHAwAAFAAAAAAAAAABelIAAXwIARsMBASIAQAASAAAABwAAACg
6P//IwAAAAAEAQAAAA4IhQIEAgAAAA0FBAcAAAAuBAQDAAAALggEAwAAAC4MBAMAAAAuEAQDAAAA
LhQEDQAAAC4AACgAAABoAAAAeOj//w4CAAAABAEAAAAOCIUCBAIAAAANBQQFAAAAhgSHAwAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAR0NDOiAoR05VKSAzLjIAAEdDQzogKEdOVSkgMy4yAABHQ0M6IChH
TlUpIDMuMgAALnNoc3RydGFiAC50ZXh0AC5yb2RhdGEALmRhdGEALmVoX2ZyYW1lAC5ic3MALmNv
bW1lbnQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALAAAAAQAAAAYA
AAB0gAQIdAAAABwfAAAAAAAAAAAAAAQAAAAAAAAAEQAAAAEAAAACAAAAoJ8ECKAfAAD6AwAAAAAA
AAAAAAAgAAAAAAAAABkAAAABAAAAAwAAAKCzBAigIwAAbAAAAAAAAAAAAAAAIAAAAAAAAAAfAAAA
AQAAAAMAAAAMtAQIDCQAACABAAAAAAAAAAAAAAQAAAAAAAAAKQAAAAgAAAADAAAAQLUECEAlAACA
EAAAAAAAAAAAAAAgAAAAAAAAAC4AAAABAAAAAAAAAAAAAABAJQAAMAAAAAAAAAAAAAAAAQAAAAAA
AAABAAAAAwAAAAAAAAAAAAAAcCUAADcAAAAAAAAAAAAAAAEAAAAAAAAA

--Boundary-00=_jBefBqwjH2l4luc
Content-Type: text/x-csrc;
  charset="koi8-r";
  name="nmeter.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="nmeter.c"

// Based on nanotop.c from floppyfw project
// Released under GPL
// Contact me: vda@port.imtp.ilyichevsk.odessa.ua

//TODO: 
// simplify code
// /proc/locks
// /proc/stat:
// disk_io: (3,0):(22272,17897,410702,4375,54750)
// btime 1059401962

//#include <ctype.h>
#include <sys/time.h>	// gettimeofday
#include <string.h>	// strstr etc
#include <stdarg.h>	// f(...)
#include <fcntl.h>	// O_RDONLY

#define VERSION_STR "0.7"
#define DELIM_CHAR ' '

//==============
#define NL "\n"
typedef unsigned long long ullong;
typedef unsigned long ulong;

typedef ulong sample_t;

//==============
#define proc_file_size 4096

typedef struct proc_file {
    char *name;
    int gen;
    char *file;
} proc_file;

proc_file proc_stat = { "/proc/stat", -1 };
proc_file proc_net_dev = { "/proc/net/dev", -1 };
proc_file proc_meminfo = { "/proc/meminfo", -1 };
proc_file proc_diskstats = { "/proc/diskstats", -1 };
struct timeval tv;
int gen=-1;
int is26=0;

//==============
#if 0
#include <stdio.h>
void dprintf(const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    vprintf(fmt, ap);
    va_end(ap);
}
#else
extern void dprintf(const char *fmt, ...) {}
#endif

//==============
char outbuf[4096];
char *cur_outbuf = outbuf;

extern inline void reset_outbuf() {
    cur_outbuf = outbuf;
}

extern inline int outbuf_count() {
    return cur_outbuf-outbuf;
}

extern inline void print_outbuf() {
    if(cur_outbuf>outbuf) {
	write(1, outbuf, cur_outbuf-outbuf);
	cur_outbuf = outbuf;
    }
}

void put(const char *s) {
    int sz = strlen(s);
    if(sz > (outbuf+sizeof(outbuf))-cur_outbuf)
	sz = (outbuf+sizeof(outbuf))-cur_outbuf;
    memcpy(cur_outbuf, s, sz);
    cur_outbuf += sz;
}

void put_c(char c) {
    if(cur_outbuf < outbuf+sizeof(outbuf))
	*cur_outbuf++ = c;
}

//==============
char* simple_itoa(char *s, int sz, unsigned long v, int pad) {
//==============
    s += sz;
    *--s = '\0';
    while (--sz > 0) {
        *--s = "0123456789"[v%10];
        pad--;
        v /= 10;
        if(!v && pad<=0) break;
    }
    return s;
}

//==============
int readfile_z(char *buf, int sz, const char* fname) {
//==============
    int fd;
    fd=open(fname,O_RDONLY);
    if(fd<0) return 1;
    sz = read(fd,buf,sz-1);
    close(fd);
    if(sz<0) {
	buf[0]='\0';
	return 1;
    }
    buf[sz]='\0';
    return 0;
}

//==============
int rdval(const char* p, const char* key, sample_t *vec, ...) {
//==============
    va_list arg_ptr;
    int indexline;
    int indexnext;

    p = strstr(p,key);
    if(!p) return 1;
	
    p += strlen(key);
    va_start(arg_ptr, vec);
    indexline = 1;
    indexnext = va_arg(arg_ptr, int);
    while(1) {
    	while(*p==' ' || *p=='\t') p++;
	if(*p=='\n' || *p=='\0') break;

        if(indexline == indexnext) { // read this value
            *vec++ = strtoul(p, NULL, 10);
            indexnext = va_arg(arg_ptr, int);
        }
    	while(*p > ' ') p++; // skip over value
        indexline++;
    }
    va_end(arg_ptr);
    return 0;
}

//==============
int rdval_diskstats(const char* p, sample_t *vec) {
//   1    2 3   4     5     6(rd)  7      8     9     10(wr) 11      12 13    14
//   3    0 hda 51292 14441 841783 926052 25717 79650 843256 3029804 0 148459 3956933
//   3    1 hda1 0 0 0 0 <- ignore if only 4 fields
//==============
    sample_t rd;
    int indexline = 0;
    vec[0] = 0;
    vec[1] = 0;
    while(1) {
        indexline++;
        while(*p==' ' || *p=='\t') p++;
        if(*p=='\0') break;
        if(*p=='\n') {
            indexline = 0;
	    p++;
            continue;
        }
        if(indexline == 6) {
            rd = strtoul(p, NULL, 10);
        } else
        if(indexline == 10) {
            vec[0] += rd;  // TODO: *sectorsize (don't know how to find out sectorsize)
            vec[1] += strtoul(p, NULL, 10);
    	    while(*p!='\n' && *p!='\0') p++;
	    continue;
        }
        while(*p > ' ') p++; // skip over value
    }
    return 0;
}

//==============
void scale(sample_t ul) {
//==============
    char buf[5];
    int index = 0;
    ul *= 10;
    if(ul>9999*10) { // do not scale if 9999 or less
	while(ul >= 10000) {
	    ul /= 1024;
	    index++;
	}
    }

    if(!index) {/* use 1234 format */
	buf[0] = " 123456789"[ul/10000];
	if(buf[0]== ' ') buf[1] = " 123456789"[ul/1000%10];
	            else buf[1] = "0123456789"[ul/1000%10];
	if(buf[1]== ' ') buf[2] = " 123456789"[ul/100%10];
                    else buf[2] = "0123456789"[ul/100%10];
	buf[3] = "0123456789"[ul/10%10];
    } else if(ul>=100) { /* use 123k format */
	if( (buf[0]= " 123456789"[ul/1000]) == ' ')
	    buf[1] = " 123456789"[ul/100%10];
	else
	    buf[1] = "0123456789"[ul/100%10];
	buf[2] = "0123456789"[ul/10%10];
	buf[3] = " kMGTEP"[index];
    } else { /* use 1.2M format */
	buf[0] = "0123456789"[ul/10];
	buf[1] = '.';
	buf[2] = "0123456789"[ul%10];
	buf[3] = " kMGTEP"[index];
    }
    buf[4] = 0;
    put(buf);
}

//==============
const char* prepare(proc_file *pf) {
    if(!pf->file) pf->file = (char*)malloc(proc_file_size);
    if(pf->gen != gen) {
	pf->gen = gen;
	readfile_z(pf->file, proc_file_size, pf->name);
    }
    return pf->file;
}

//==============
#define S_STAT(a) \
typedef struct a { \
    struct s_stat *next; \
    int (*collect)(struct a *s); \
    const char *label; \
    int width;

S_STAT(s_stat)
} s_stat;

#define MALLOC_STAT(type,var) type *var = (type*)malloc(sizeof(type))

//==============
S_STAT(cpu_stat)
    sample_t old[4];
    int bar_sz;
    char *bar;
} cpu_stat;

//==============
int collect_cpu(cpu_stat *s) {
//==============
    sample_t data[4];
    sample_t frac[4];
    sample_t all = 0;
    int norm_all = 0;
    int bar_sz = s->bar_sz;
    char *bar = s->bar;
    int i;

    if(rdval(prepare(&proc_stat), "cpu ", data, 1, 2, 3, 4))
	return 1;
    
    put_c('[');

//dprintf("data1:");
    for(i=0; i<4; i++) {
	sample_t old = s->old[i];
	if(data[i] < old) old = data[i];	//sanitize
        s->old[i] = data[i];
        all += (data[i] -= old);
//dprintf(" %lu",data[i]);
    }
//dprintf(" all %lu\n",all);

    if(all) {
//dprintf("data2:");
	for(i=0; i<4; i++) {
	    ullong t = bar_sz*(ullong)data[i];
	    norm_all += data[i] = t / all;
	    frac[i] = t % all;
//dprintf(" %lu/%lu",data[i],frac[i]);
	}
//dprintf(" norm_all %lu\n",norm_all);
    
	while(norm_all<bar_sz) {
	    sample_t max=frac[0]; int pos=0;
	    //for(i=1; i<4; i++) if(frac[i]>=max) max=frac[i], pos=i;
	    if(frac[1]>=max) max=frac[1], pos=1;
	    if(frac[2]>=max) max=frac[2], pos=2;
	    if(frac[3]>=max) max=frac[3], pos=3;
	    frac[pos]=0;	//avoid bumping same value twice
	    data[pos]++;
//dprintf("bumped %i\n",pos);
	    norm_all++;
        }
    
//dprintf("bar_sz %i\n",bar_sz);
//dprintf("sys %i\n",data[2]);
//dprintf("usr %i\n",data[0]);
//dprintf("nice %i\n",data[1]);
	memset(bar,'.',bar_sz);
	memset(bar,'S',data[2]); bar+=data[2]; //sys
	memset(bar,'U',data[0]); bar+=data[0]; //usr
	memset(bar,'N',data[1]); bar+=data[1]; //nice
    } else {
	memset(bar,'?',bar_sz);
    }
    put(s->bar);
    put_c(']');
    return 0;
}

//==============
s_stat* init_cpu(const char *param) {
//==============
    int sz;
    MALLOC_STAT(cpu_stat,s);
    s->collect = collect_cpu;
    s->label = "cpu ";
    s->width = 4;

    sz = strtol(param, NULL, 0);
    if(sz<10) sz=10;
    if(sz>1000) sz=1000;

    s->bar = (char*)malloc(sz+1);
    s->bar[sz]=0;
    s->bar_sz = sz;
    s->width = sz+2;
    return (s_stat*)s;
}

//==============
S_STAT(int_stat)
    sample_t old;
    int no;
    char numlabel[6];
} int_stat;

//==============
int collect_int(int_stat *s) {
//==============
    sample_t data[1];

    if(rdval(prepare(&proc_stat), "intr", data, s->no))
	return 1;

    sample_t old = s->old;
    if(data[0] < old) old = data[0];	//sanitize
    s->old = data[0];
    scale(data[0] - old);
    return 0;
}

//==============
s_stat* init_int(const char *param) {
//==============
    MALLOC_STAT(int_stat,s);
    s->collect = collect_int;
    s->width = 4;
    if(param[0]=='\0') {
	s->no = 1;
	s->label = "int ";
    } else {
	int n = strtoul(param, NULL, 0);
	s->no = n+2;
	s->label = s->numlabel;
	s->numlabel[0]='i';
	s->numlabel[1]='n';
	s->numlabel[2]='t';
	s->numlabel[3]=(n<=9 ? '0'+n : n+('A'-10));
	s->numlabel[4]=' ';
	s->numlabel[5]='\0';
    }
    return (s_stat*)s;
}

//==============
S_STAT(ctx_stat)
    sample_t old;
} ctx_stat;

//==============
int collect_ctx(ctx_stat *s) {
//==============
    sample_t data[1];

    if(rdval(prepare(&proc_stat), "ctxt", data, 1))
	return 1;

    sample_t old = s->old;
    if(data[0] < old) old = data[0];	//sanitize
    s->old = data[0];
    scale(data[0] - old);
    return 0;
}

//==============
s_stat* init_ctx(const char *param) {
//==============
    MALLOC_STAT(ctx_stat,s);
    s->collect = collect_ctx;
    s->label = "ctx ";
    s->width = 4;
    return (s_stat*)s;
}

//==============
S_STAT(blk_stat)
    const char* lookfor;
    sample_t old[2];
} blk_stat;

//==============
int collect_blk24(blk_stat *s) {
//==============
    sample_t data[2];
    int i;
    if(rdval(prepare(&proc_stat), s->lookfor, data, 1, 2))
    	return 1;

    for(i=0; i<2; i++) {
	sample_t old = s->old[i];
	if(data[i] < old) old = data[i];	//sanitize
	s->old[i] = data[i];
	data[i] -= old;
    }
    scale(data[0]*1024);
    put_c(' ');
    scale(data[1]*1024);
    return 0;
}

//==============
int collect_blk26(blk_stat *s) {
//==============
    sample_t data[2];
    int i;
    if(rdval_diskstats(prepare(&proc_diskstats), data))
	return 1;

    for(i=0; i<2; i++) {
	sample_t old = s->old[i];
	if(data[i] < old) old = data[i];	//sanitize
	s->old[i] = data[i];
	data[i] -= old;
    }
    scale(data[0]*512);
    put_c(' ');
    scale(data[1]*512);
    return 0;
}

//==============
int collect_blk(blk_stat *s) {
//==============
    if(is26) return collect_blk26(s);
    return collect_blk24(s);
}

//==============
s_stat* init_blk(const char *param) {
//==============
    MALLOC_STAT(blk_stat,s);
    s->collect = collect_blk;
    if(param[0]=='s') {
	s->label = "sio ";
	s->lookfor = "swap";
    } else {
	s->label = "bio ";
	s->lookfor = "page";
    }
    s->width = 9;
    return (s_stat*)s;
}

//==============
S_STAT(fork_stat)
    sample_t old;
} fork_stat;

//==============
int collect_fork(fork_stat *s) {
//==============
    sample_t data[1];

    if(rdval(prepare(&proc_stat), "processes", data, 1))
	return 1;

    sample_t old = s->old;
    if(data[0] < old) old = data[0];	//sanitize
    s->old = data[0];
    scale(data[0] - old);
    return 0;
}

//==============
s_stat* init_fork(const char *param) {
//==============
    MALLOC_STAT(fork_stat,s);
    s->collect = collect_fork;
    s->label = "fork";  // no trailing space: there usually <1000 forks,
    s->width = 4;       // we trade usual "fork    3" for rare "fork1234"
    return (s_stat*)s;
}

//==============
S_STAT(if_stat)
    sample_t old[4];
    const char *device;
    char *device_colon;
} if_stat;

//==============
int collect_if(if_stat *s) {
//==============
    sample_t data[4];
    int i;

    if(rdval(prepare(&proc_net_dev), s->device_colon, data, 1, 3, 9, 11))
	return 1;

    //dprintf("data1:");
    for(i=0; i<4; i++) {
	sample_t old = s->old[i];
	if(data[i] < old) old = data[i];	//sanitize
        s->old[i] = data[i];
        data[i] -= old;
	//dprintf(" %lu",data[i]);
    }
    //dprintf("\n");
    
    put_c(data[1] ? '*' : ' ');
    scale(data[0]);
    put_c(data[3] ? '*' : ' ');
    scale(data[2]);
    return 0;
}

//==============
s_stat* init_if(const char *device) {
//==============
    MALLOC_STAT(if_stat,s);
    s->collect = collect_if;
    s->label = device;
    s->width = 10;
    
    s->device = device;
    s->device_colon = (char*)malloc(strlen(device)+2);
    strcpy(s->device_colon,device);
    strcat(s->device_colon,":");
    return (s_stat*)s;
}

//==============
S_STAT(mem_stat)
    char opt;
} mem_stat;

//==============
int collect_mem(mem_stat *s) {
//==============
//        total:    used:    free:  shared: buffers:  cached:
//Mem:  29306880 21946368  7360512        0  2101248 11956224
//Swap: 100655104 10207232 90447872
//MemTotal:        28620 kB
//MemFree:          7188 kB
//MemShared:           0 kB  <-- ?
//Buffers:          2052 kB
//Cached:           9080 kB
//SwapCached:       2596 kB  <-- ?

    // Not available in 2.6:
    //if(rdval(prepare(&proc_meminfo), "Mem:", data, 1, 2, 5, 6))
    //    return 1;
    sample_t m_total;
    sample_t m_free;
    sample_t m_bufs;
    sample_t m_cached;
    if(rdval(prepare(&proc_meminfo), "MemTotal:", &m_total , 1)) return 1;
    if(rdval(prepare(&proc_meminfo), "MemFree:",  &m_free  , 1)) return 1;
    if(rdval(prepare(&proc_meminfo), "Buffers:",  &m_bufs  , 1)) return 1;
    if(rdval(prepare(&proc_meminfo), "Cached:",   &m_cached, 1)) return 1;
    switch(s->opt) {
    case 'f':
        scale((m_free + m_bufs + m_cached)<<10); break;
    case 't':
        scale(m_total<<10); break;
    default:
        scale((m_total - m_free - m_bufs - m_cached)<<10); break;
    }
    return 0;
}

//==============
s_stat* init_mem(const char *param) {
//==============
    MALLOC_STAT(mem_stat,s);
    s->collect = collect_mem;
    s->width = 4;
    s->opt=param[0];
    switch(param[0]) {
    case 'f':
	s->label = "free "; break;
    case 't':
	s->label = "tot "; break;
    default:
	s->label = "mem "; break;
    }
    return (s_stat*)s;
}

//==============
S_STAT(swp_stat)
} swp_stat;

//==============
int collect_swp(swp_stat *s) {
//==============
    sample_t data[1];
    if(rdval(prepare(&proc_meminfo), "Swap:", data, 2))
	return 1;
	
    scale(data[0]);
    return 0;
}

//==============
s_stat* init_swp(const char *param) {
//==============
    MALLOC_STAT(swp_stat,s);
    s->collect = collect_swp;
    s->label = "swp ";
    s->width = 4;
    return (s_stat*)s;
}

//==============
S_STAT(fd_stat)
} fd_stat;

//==============
int collect_fd(fd_stat *s) {
//==============
    char file[4096];
    sample_t data[2];

    readfile_z(file, sizeof(file), "/proc/sys/fs/file-nr");
    if(rdval(file, "", data, 1, 2))
	return 1;

    scale(data[0]-data[1]);
    return 0;
}

//==============
s_stat* init_fd(const char *param) {
//==============
    MALLOC_STAT(fd_stat,s);
    s->collect = collect_fd;
    s->label = "fd ";
    s->width = 4;
    return (s_stat*)s;
}

//==============
S_STAT(time_stat)
    int prec;
    int scale;
} time_stat;

//==============
int collect_time(time_stat *s) {
//==============
    char buf[16];	// 12:34:56.123456<eol>
			// 1234567890123456
    simple_itoa(buf, 3, tv.tv_sec/(60*60)%24, 2);
    buf[2] = ':';
    simple_itoa(buf+3, 3, tv.tv_sec/60%60, 2);
    buf[5] = ':';
    simple_itoa(buf+6, 3, tv.tv_sec%60, 2);
    
    if(s->prec) {
	buf[8] = '.';
	//simple_itoa(buf+9, s->prec+1, (tv.tv_usec + s->scale/2) / s->scale, s->prec);
	// (fixme: round up seconds too!)
	// so... rounding omitted! just use more prec if you need it! ;)
	simple_itoa(buf+9, s->prec+1, tv.tv_usec / s->scale, s->prec);
    }
    put(buf);
    return 0;
}

//==============
s_stat* init_time(const char *param) {
//==============
    int prec;
    MALLOC_STAT(time_stat,s);
    s->collect = collect_time;
    s->label = "";
    prec = param[0]-'0';
    if(prec<0) prec = 0;
    else if(prec>6) prec = 6;
    s->width = 8+prec + (prec!=0);
    s->prec = prec;
    s->scale = 1;
    while(prec++ < 6)
	s->scale *= 10;
    return (s_stat*)s;
}

//==============
S_STAT(extern_stat)
    int ifd,ofd;
    char *buf;
    char *cur;
} extern_stat;

#define WIDTH

//==============
int collect_extern(extern_stat *s) {
//==============
    int sz;
    char *p;
    int buffered = s->cur - s->buf;
    
    s->buf[40] = 0;
    p = strchr(s->buf,'\n');
    if(!p || p > s->cur) {
	do {
	    sz = read(s->ofd,s->cur,40 - buffered);
	    if(sz<0) exit(1);
	    buffered += sz;
	    p = strchr(s->cur,'\n');
	    s->cur = s->buf+buffered;
	    if(p > s->cur) p=0;
	} while(!p && buffered<40);
	if(!p) p=s->buf+40;
    }
    
    *p++ = 0;
    put(s->buf);
    s->cur = s->buf;
    while(p < s->buf+buffered) {
	put_c('=');
	*s->cur++ = *p++;
    }
    while(p <= s->buf+40) {
	put_c('='); p++;
    }
    return 0;
}

//#include <stdio.h>

void myexec(void *param) {
    char **argv = (char **)param;
    execv(argv[0], argv);
}

int start_child(int *i,int *o,void (*f)(void*),void *param) {
    int pid;
//printf("execv(%s, argv);\n",((char**)param)[0]);
    {
	int in[2];
	int out[2];
	pipe(in);
	pipe(out);
	pid = fork();
	switch(pid) {
	case -1: /* error */
	    return -1;
	case 0: /* child */
	    dup2(in[0],0); close(in[0]); close(in[1]);
	    dup2(out[1],1); close(out[0]); close(out[1]);
	    f(param);
	    exit(1);
	default: /* parent */
	    close(in[0]);
	    if(i) *i=in[1]; else close(in[1]);
	    if(o) *o=out[0]; else close(out[0]);
	    close(out[1]); 
	    return pid;
	}
    }
}

//==============
s_stat* init_extern(const char *param) {
//==============
    int pid;
    char *argv[] = { (char*)param, 0 };
    MALLOC_STAT(extern_stat,s);
    s->collect = collect_extern;
    s->label = "extern ";
    s->width = 40;
    s->buf = (char*)malloc(41);
    s->cur = s->buf;
    pid = start_child(&s->ifd, &s->ofd, myexec, argv);
    if(pid<0) exit(1);
//printf("pid,i,o=%d %d %d\n",pid,s->ifd,s->ofd);
    return (s_stat*)s;
}

//==============
char *header;
//==============
void build_n_put_hdr(s_stat *s) {
//==============
    while(s) {
	int l = 0;
        if(s->label[0]!=' ') {
    	    put(s->label);
	    l = strlen(s->label);
	}
	while(l <= s->width) {
	    put_c(' ');	
	    l++;
	}
        s = s->next;
    }
    put_c('\n');

    header = (char*)malloc(outbuf_count()+1);
    memcpy(header, outbuf, outbuf_count());
    header[outbuf_count()] = '\0';
    //print_outbuf();
}

//==============
void put_hdr(s_stat *s) {
//==============
    if(!header) build_n_put_hdr(s);
    else {
	put(header);
	//print_outbuf();
    }
}

//==============
void run_once(s_stat *s, int without_headers) {
//==============
    gen++;
    int first = 1;
    while(s) {
	if(s->label[0]!=' ') {		// "[prev ][LABEL]data
	    if(!first) put_c(DELIM_CHAR);
    	    if(!without_headers) put(s->label);
	} else {			// "prevLABELdata
	    put(s->label+1);
	}
        if(s->collect(s)) {
	    int w = s->width;
	    while(w-- > 0)
		put_c('?');
	}
        s = s->next;
	first = 0;
    }
}

//==============
typedef s_stat* init_func(const char *param);

const char options[] = "ncmsfixptbe";
init_func* init_functions[] = {
    init_if,  
    init_cpu, 
    init_mem, 
    init_swp, 
    init_fd,  
    init_int, 
    init_ctx, 
    init_fork,
    init_time,
    init_blk,
    init_extern,
};

//==============
int main(int argc, char* argv[]) {
//==============
    struct timezone tz;
    s_stat *first = 0;
    s_stat *last = 0;
    s_stat *s;
    int delta = 1000000;
    int deltanz = 1000000;
    int print_headers = 0;
    char *final_str = "\n";
    char *p;
    int fd;
    int i;
    
    if(argc==1) {
	put(
	"nmeter " VERSION_STR " allows you to monitor your system in real time" NL
	NL
	"Options:" NL
	"c[N]	monitor CPU. N - bar size, default 10" NL
	"nIFACE	monitor network interface IFACE" NL
	"m[f/t]	monitor allocated/free/total memory" NL
	"s	monitor allocated swap" NL
	"f	monitor number of used filedescriptors" NL
	"i[NN]	monitor total/specific IRQ rate" NL
	"x	monitor context switch rate" NL
	"p	monitor process creation rate" NL
	"b[s]	monitor block io (swap io)" NL
	"t[N]	show time (with N decimal points)" NL
	"d[N]	milliseconds between updates. Default 1000" NL
	"h[N]	print headers above numbers (each N lines, default once)" NL
	"lLABEL	specify label for previous item" NL
	"LLABEL	same + label will be printed without surrounding blanks" NL
	"r	print <cr> instead of <lf> at EOL. Try it ;)" NL
	);
	print_outbuf();
	return 0;
    }

    fd = open("/proc/version",O_RDONLY);
    if(fd>=0) {
	char buf[32];
	if(0<read(fd,buf,sizeof(buf)))
	    is26 = (strstr(buf,"Linux version 2.6.")!=NULL);
	close(fd);
    }
    for(i=1; i<argc; i++) {
	p = strchr(options,argv[i][0]);
	if(p) {
	    s = init_functions[p-options](argv[i]+1);
	    if(s) {
		s->next = 0;
		if(!first)
		    first = s;
		else
		    last->next = s;
		last = s;
	    }
	}

// You have to see it... gcc 3.2 coded switch() as 40 element jump table
// OH NO! >>>:^O
/*
#define SW(a) switch(a) {
#define ENDSW }
#define CASE(a,b) case (b): {
#define ENDCASE }
*/
#define SW(a) do {
#define ENDSW } while(0);
#define CASE(a,b) if((a)==(b)) {
#define ENDCASE }
	SW(argv[i][0])
	CASE(argv[i][0],'r')
	    final_str = "\r";
	    break;
	ENDCASE
	CASE(argv[i][0],'d')
	    delta = strtol(argv[i]+1, NULL, 0)*1000;
	    deltanz = delta>0? delta : 1;
	    break;
	ENDCASE
	CASE(argv[i][0],'h')
	    if(argv[i][1]=='\0')
		print_headers = -1;
	    else
		print_headers = strtol(argv[i]+1, NULL, 0);
	    break;
	ENDCASE
	CASE(argv[i][0],'l')
	    if(last)
		last->label=argv[i]+1;
	    break;
	ENDCASE
	CASE(argv[i][0],'L')
	    if(last) {
		argv[i][0]=' ';
		last->label=argv[i];
	    }
	    break;
	ENDCASE
	ENDSW
    }
	
    if(print_headers == -1) {
	build_n_put_hdr(first);
	print_outbuf();
    }
    run_once(first, print_headers);
    reset_outbuf();
    if(delta>=0) {
	//gettimeofday(&tv,0);
	gettimeofday(&tv,&tz); //
	usleep(delta>1000000 ? 1000000 : delta-tv.tv_usec%deltanz);
    }
    while(1) {
	gettimeofday(&tv,&tz);
        tv.tv_sec -= tz.tz_minuteswest*60;

	if(print_headers > 0 && gen%print_headers == 0)
	    put_hdr(first);
	run_once(first, print_headers);
	put(final_str);
	print_outbuf();

	// Negative delta -> no usleep at all
	// This will hog the CPU but you can have REALLY GOOD
	// time resolution ;)
	// TODO: detect and avoid useless updates
	// (like: nothing happens except time)
        if(delta>=0) {
	    int rem = delta - ((ullong)tv.tv_sec*1000000+tv.tv_usec)%deltanz;
	    // Sometimes kernel wakes us up just a tiny bit earlier than asked
	    // Do not go to very short sleep in this case
	    if(rem < delta/128) {
		rem += delta;
	    }
	    usleep(rem);
	}
    }

    return 0;
}

--Boundary-00=_jBefBqwjH2l4luc--

